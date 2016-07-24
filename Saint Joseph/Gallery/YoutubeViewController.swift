//
//  YoutubeViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/23/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import YouTubePlayer

class YoutubeViewController: UIViewController {
    
    var videoID: String!

    @IBOutlet weak var videoPlayer: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let videoURL = "http://www.youtube.com/embed/" + videoID
        let htmlString = "<iframe width = \(videoPlayer.frame.width) height = \(videoPlayer.frame.height) src = \(videoURL)?\" frameborder=\"0\" allowfullscreen></iframe>"
        videoPlayer.loadHTMLString(htmlString, baseURL: NSBundle.mainBundle().bundleURL)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
