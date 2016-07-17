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
typealias OnNewsFeed                  = OLNewsFeed -> Void
typealias JSONDictionary              = [String : AnyObject]

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
        
        if let params = params {
            switch requestMethod {
            case .GET, .DELETE:
                var queryItems: [NSURLQueryItem] = []
                
                for (key, value) in params {
                    queryItems.append(NSURLQueryItem(name: "\(key)".urlEscapedString(), value: "\(value)".urlEscapedString()))
                }
//                if queryItems.count > 0 {
//                    let components = NSURLComponents(URL: request.URL!, resolvingAgainstBaseURL: false)
//                    components?.queryItems = queryItems
//                    
//                    // Following replacement of strings needs to be done in a better way.. For Device integration API, ROR & .Net
//                    
//                    // .Net
//                    components?.percentEncodedQuery = components?.percentEncodedQuery?.stringByReplacingOccurrencesOfString("UNIQUE", withString: "%26", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                    components?.percentEncodedQuery = components?.percentEncodedQuery?.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                    
//                    // For ROR
//                    components?.percentEncodedQuery = components?.percentEncodedQuery?.stringByReplacingOccurrencesOfString("%2520", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
//                    
//                    request.URL = components?.URL
//                } else {
//                    logError("\(requestMethod) request failed to convert to a valid query string with params \(params)")
//                }
            default:
                break
            }
        }
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
                print("Response URL-> \(urlRequest)")
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
                  //  print(customErrorMessage)
//                    switch (statusCode, route) {
//                        
//                    print("Error Occured")
////                    case (401, _):
////                        if responseString == "Access Token expired or Invalid" || responseString.length == 1 {
////                            if let _ = KeyChainStore.sharedStore().token {
////                                customErrorMessage = Constants.ErrorMessage.SessionExpired
////                                self.logout()
////                            }
//                            onErrorMessage(responseString)
//                            return
//                        }
//                    default:
//                        break
//                    }
                    
                 //   let errorMessage = customErrorMessage ?? "Error Code: \(statusCode)"
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
        enqueueRequest(.GET, .News, onSuccessResponse: { responseString in
            let newsFeed = OLNewsFeed(jsonString: responseString)
            onSuccess(newsFeed)
            }, onErrorMessage: onError)
    }
    
    func fetchGallery(onSuccessGallery onSuccess: OnGallery, onError: OnErrorMessage) {
        enqueueRequest(.GET, .Gallery, onSuccessResponse: { _ in
            
            }, onErrorMessage: onError)
    }
}