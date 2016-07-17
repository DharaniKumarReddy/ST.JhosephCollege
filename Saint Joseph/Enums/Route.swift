//
//  Route.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

let BASEURL = "http://sjec.edu.in/sjec_app/sjec_"
let PHP = ".php"

enum Route {
    case News               //GET
    case Gallery             //GET
    
    var absoluteURL: NSURL {
        return NSURL(string: BASEURL + apiPath + PHP)!
    }
    
    private var apiPath: String {
        switch self {
        case .News:
            return "news"
        case.Gallery:
            return "images"
        }
    }
    
    func trackingMessageForRequestMethod(method: String) -> String? {
        switch self {
        case .News:
            return "News has been watched"
        case.Gallery:
            return "Gallery has been watched"
        }
    }
    
}