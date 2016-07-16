//
//  Route.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

let BASEURL = "http://sjec.edu.in/sjec_app/sjec_"

enum Route {
    case News               //GET
    
    var absoluteURL: NSURL {
        return NSURL(string: BASEURL + apiPath)!
    }
    
    private var apiPath: String {
        switch self {
        case .News:
            return "news.php"
        }
    }
    
    func trackingMessageForRequestMethod(method: String) -> String? {
        switch self {
        case .News:
            return "News has been watched"
        }
    }
    
}