//
//  Constants.swift
//  Saint Joseph
//
//  Created by Dharani on 7/13/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation
struct Constants {
    
    struct StoryBoard {
        static let Main         = "Main"
        static let News        = "News"
        static let Gallery      = "Gallery"
    }
    
    struct NavigationController {
        static let DashboardNavigationController = "DashboardNavigationController"
    }
    
    struct  ViewControllerIdentifier {
        static let YoutubeViewController     = "YoutubeViewController"
        static let GalleryListViewController = "GalleryListViewController"
        static let FullNewsViewController   = "FullNewsViewController"
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
    }
}
