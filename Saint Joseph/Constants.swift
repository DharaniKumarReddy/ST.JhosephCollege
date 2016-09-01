//
//  Constants.swift
//  Saint Joseph
//
//  Created by Dharani on 7/13/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

let ACADEMICS_URL="http://sjpuc.in/sjpu_app/admissionprocedure.html";
let ERP_URL="http://my-lyceum.net/MyLyceum/Home.aspx";
let PRINCIPAL_MSG="http://sjpuc.in/sjpu_app/principals.html";
let RECTOR_MSG="http://sjpuc.in/sjpu_app/rector.html"
let COLLEGE_WEBSITE="http://www.sjpuc.in"

struct Constants {
    
    struct StoryBoard {
        static let Main         = "Main"
        static let News        = "News"
        static let Gallery      = "Gallery"
    }
    
    struct NavigationController {
        static let DashboardNavigationController  = "DashboardNavigationController"
        static let HtmlLoaderNavigationController = "HtmlLoaderNavigationController"
        static let AluminiNavigationController        = "AluminiNavigationController"
    }
    
    struct  ViewControllerIdentifier {
        static let YoutubeViewController     = "YoutubeViewController"
        static let GalleryListViewController = "GalleryListViewController"
        static let FullNewsViewController   = "FullNewsViewController"
        static let HtmlLoaderViewController = "HtmlLoaderViewController"
    }

    struct ErrorMessage {
        static let InternetConnectionLost             = "Internet connection lost"
    }
    
    struct UserDefaults {
        static let NewsUpdated                  = "NewsUpdated"
    }
    
    struct  SegueIdentifier {
        static let SlidingViewControllerSegue           = "SlidingViewControllerSegue"
        static let NewsSegue                                    = "NewsSegue"
        static let AnnouncementsSegue                   = "AnnouncementsSegue"
        static let EventsSegue                                  = "EventsSegue"
        static let GallerySegue                                 = "GallerySegue"
        static let VideosSegue                                  = "VideosSegue"
        static let AcademicSegue                             = "AcademicSegue"
        static let ERPSegue                                     = "ERPSegue"
    }
    
    struct Title {
        static let Events                           = "Events"
        static let Announcements            = "Announcements"
        static let Gallery                          = "Gallery"
        static let Videos                           = "Videos"
    }
    
    struct CellIdentifier {
        static let EventsCell                           = "EventsCell"
        static let AnnouncementsCell            = "AnnouncementsCell"
        static let VideoCollectionViewCell     = "VideoCollectionViewCell"
        static let GalleryCollectionViewCell   = "GalleryCollectionViewCell"
        static let FullNewsTableCell              = "FullNewsTableCell"
        static let AluminiTableViewCell          = "AluminiTableViewCell"
    }
}
