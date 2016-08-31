//
//  APICaller.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

typealias OnSuccessResponse     = String -> Void
typealias OnErrorMessage            = String -> Void

typealias OnGallery                       = OLGallery -> Void
typealias OnVideos                        = OLVideos -> Void
typealias OnNewsFeed                 = OLNewsFeed -> Void
typealias JSONDictionary              = [String : String]

private enum RequestMethod: String, CustomStringConvertible {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
    
    var description: String {
        return rawValue
    }
}

class APICaller {
    let MAX_RETRIES = 2
    private var urlSession: NSURLSession
    
    private init() {
        urlSession = APICaller.createURLSession()
    }
    
    class func getInstance() -> APICaller {
        struct Static {
            static let instance = APICaller()
        }
        return Static.instance
    }
    
    private class func createURLSession() -> NSURLSession {
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        configuration.URLCache = nil
        configuration.requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        
        return NSURLSession(configuration: configuration, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    private func resetURLSession() {
        urlSession.invalidateAndCancel()
        urlSession = APICaller.createURLSession()
    }
    
    private func createRequest(requestMethod: RequestMethod, _ route: Route, params: JSONDictionary? = nil) -> NSURLRequest {
        let request = NSMutableURLRequest(URL: route.absoluteURL)
        
        request.HTTPMethod = requestMethod.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if let params = params {
            switch requestMethod {
            case .GET, .DELETE:
                break
            case .POST, .PUT:
                var error: NSError?
                do {
                    let body = try NSJSONSerialization.dataWithJSONObject(params, options: [])
                    request.HTTPBody = body
                } catch let error1 as NSError {
                    error = error1
                    if (error?.localizedDescription) != nil {
                       // logError(errorMessage)
                    } else {
                        //logError("Unexpected JSON Parse Error requestWithOperation: \(requestMethod) \(route.absoluteURL)")
                    }
                }
            }
        }
        print("Response URL-> \(request)")
        return request
    }
    
    private func enqueueRequest(requestMethod: RequestMethod, _ route: Route, params: JSONDictionary? = nil, retryCount: Int = 0, onSuccessResponse: String -> Void, onErrorMessage: OnErrorMessage) {
        let urlRequest = createRequest(requestMethod, route, params: params)
        let dataTask = urlSession.dataTaskWithRequest(urlRequest) { data, response, error in
            if let httpResponse = response as? NSHTTPURLResponse {
                var statusCode = httpResponse.statusCode
                var responseString:String = ""
                if let responseData = data {
                    responseString = NSString(data: responseData, encoding: NSUTF8StringEncoding) as? String ?? ""
                }else {
                    statusCode = 450
                }
              //  logResponse(httpResponse, request: urlRequest, responseString: responseString)
                print(responseString)
                switch statusCode {
                case 200...299:
                    // Success Response
                    if let _ = route.trackingMessageForRequestMethod(urlRequest.HTTPMethod!) {
                    }
                    onSuccessResponse(responseString)
                default:
                    // Failure Response
                    let _: String?
                    onErrorMessage(responseString)
                }
                
            } else if let error = error {
                var errorMessage: String
                switch error.code {
                case NSURLErrorNotConnectedToInternet:
                    errorMessage = Constants.ErrorMessage.InternetConnectionLost
                case NSURLErrorNetworkConnectionLost:
                    if retryCount < self.MAX_RETRIES {
                        print("Retrying after NSURLErrorNetworkConnectionLost error")
                        self.enqueueRequest(requestMethod, route, params: params, retryCount: retryCount + 1, onSuccessResponse: onSuccessResponse, onErrorMessage: onErrorMessage)
                        return
                        
                    } else {
                        errorMessage = error.localizedDescription
                    }
                default:
                    errorMessage = error.localizedDescription
                }
                print(errorMessage)
            //    OLHNotificationMessageManager.sharedInstance().showErrorNotification(errorMessage)
                onErrorMessage(error.localizedDescription)
            } else {
                assertionFailure("Either an httpResponse or an error is expected")
            }
        }
        
        dataTask.resume()
    }
    
    func fetchNews(onSuccessNews onSuccess: OnNewsFeed, onError: OnErrorMessage)  {
        let defaults = NSUserDefaults.standardUserDefaults()
        let updatedDate = defaults.valueForKey(Constants.UserDefaults.NewsUpdated)
        var params = JSONDictionary()
        if updatedDate != nil {
            params["updated"] = "\(updatedDate!)"
        }
        enqueueRequest(.POST, .News, params: params, onSuccessResponse: { responseString in
            let newsFeed = OLNewsFeed(jsonString: responseString)
            onSuccess(newsFeed)
            }, onErrorMessage: onError)
    }
    
    func fetchGallery(onSuccessGallery onSuccess: OnGallery, onError: OnErrorMessage) {
        enqueueRequest(.GET, .Gallery, params: ["news_id" : "44"], onSuccessResponse: { response in
            let galleryItems = OLGallery(jsonString: response)
            onSuccess(galleryItems)
            }, onErrorMessage: onError)
    }
    
    func fetchVideos(onSuccessVideos onSucess: OnVideos, onError: OnErrorMessage) {
        enqueueRequest(.GET, .Videos, onSuccessResponse: { response in
            let videos = OLVideos(jsonString: response)
            onSucess(videos)
            }, onErrorMessage: onError)
    }
}