//
//  GalleryViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/16/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import YouTubePlayer

class GalleryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ChooseItem {

    var controllerType: ControllerType!
    
    var videos: [OLVideo]!
    
    var gallery: [OLImageItem]!
    
    enum ControllerType {
        case Gallery, Videos
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if controllerType == .Gallery {
            title = Constants.Title.Gallery
            fetchGallery()
        } else {
            title = Constants.Title.Videos
            fetchVideos()
            videos = sampleVideos()
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK:- API Caller Method
    
    
    
    func sampleVideos() -> [OLVideo] {
        let video1 = OLVideo()
        video1.id = "1"
        video1.title = ""
        video1.videoID = "Jig9vFzFmmo"
        let video2 = OLVideo()
        video2.id = "2"
        video2.title = ""
        video2.videoID = "baTldJdcpwM"
        let video3 = OLVideo()
        video3.id = "3"
        video3.title = ""
        video3.videoID = "B2pTQD4K4AU"
        let video4 = OLVideo()
        video4.id = "3"
        video4.title = ""
        video4.videoID = "vv8DUpGc-MQ"
        
        return [video1, video2, video3, video4]
    }
    
    private func fetchGallery() {
        APICaller.getInstance().fetchGallery(
            onSuccessGallery: { galleryItems in
                print(galleryItems)
            }, onError: { _ in
        })
    }
    
    private func fetchVideos() {
        APICaller.getInstance().fetchVideos(onSuccessVideos: { videoData in
            
            }, onError: { _ in
            
        })
    }
    
    // MARK:- UITableView Data Source Methods
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? CollectionViewTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerType == .Gallery ? 2 : videos.count/2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCellWithIdentifier("CollectionViewTableViewCell") as! CollectionViewTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("CollectionViewTableViewCell", forIndexPath: indexPath) as! CollectionViewTableViewCell
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Adjust cell size for orientation
        let width = UIScreen.mainScreen().bounds.width / 2
        return CGSizeMake(width, 119.0);
    }
    
    // MARK:- UICollectionView DataSource Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if controllerType == .Gallery {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.CellIdentifier.GalleryCollectionViewCell, forIndexPath: indexPath) as! GalleryCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.CellIdentifier.VideoCollectionViewCell, forIndexPath: indexPath) as! VideoCollectionViewCell
            cell.delegate = self
            let videoNumber = (collectionView.tag * 1) + (collectionView.tag + indexPath.row)
            let video = videos[videoNumber]
            cell.videoButton.tag = videoNumber
            updateImage(video.videoID, indexPath: indexPath, collectionView: collectionView)
            return cell
        }
    }
    
    func updateImage(imageID: String, indexPath: NSIndexPath, collectionView: UICollectionView) {
        // We should perform this in a background thread
        let urlString = "http://img.youtube.com/vi/" + imageID + "/mqdefault.jpg"
        let url = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                let image = UIImage(data: data!)
                // Update the cell
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? VideoCollectionViewCell {
                        cellToUpdate.imageView.image = image
                    }
                })
            }
            else {
                print("Error: \(error!.localizedDescription)")
            }
        })
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }
    
    // MARK:- ChooseItem Method
    
    func chooseSelectedItem(tag: Int) {
        let youtubeViewController = UIStoryboard(Constants.StoryBoard.Gallery).instantiateViewControllerWithIdentifier(Constants.ViewControllerIdentifier.YoutubeViewController) as! YoutubeViewController
        youtubeViewController.videoID = videos[tag].videoID
        navigationController?.pushViewController(youtubeViewController, animated: true)
    }

}
