//
//  Route.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

let BASEURL = "http://sjpuc.in/"

enum Route {
    case News               //POST
    case Gallery             //GET
    case Videos             //GET
    
    var absoluteURL: NSURL {
        return NSURL(string: BASEURL + apiPath)!
    }
    
    private var apiPath: String {
        switch self {
        case .News:
            return "sjpu_app/sjpu_news.php"
        case.Gallery:
            return "sjpu_app/sjpu_images.php"
        case .Videos:
            return "sjpu_app/sjpu_videos.php"
        }
    }
    
    func trackingMessageForRequestMethod(method: String) -> String? {
        switch self {
        case .News:
            return "News has been watched"
        case.Gallery:
            return "Gallery has been watched"
        case .Videos:
            return "Videos has been watched"
        }
    }
    
}