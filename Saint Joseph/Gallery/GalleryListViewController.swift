//
//  GalleryListViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 8/4/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class GalleryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var newsID: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gallery Images"
//        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
//        let value1 = UIInterfaceOrientation.LandscapeRight.rawValue
//        UIDevice.currentDevice().setValuesForKeysWithDictionary(["orientation" : value, "orientation" : value1])
        // Do any additional setup after loading the view.
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    // MARK:- API Caller Method
    
    private func fetchGallery() {
        APICaller.getInstance().fetchGallery(
            onSuccessGallery: { galleryItems in
                print(galleryItems)
            }, onError: { _ in
        })
    }
    
    // MARK:- UITableView Data Source Methods
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? CollectionViewTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.CellIdentifier.GalleryCollectionViewCell, forIndexPath: indexPath) as! GalleryCollectionViewCell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GalleryListViewController.imageTapped(_:)))
        cell.imageView.addGestureRecognizer(tapGesture)
        return cell
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
    
    // MARK:- Tap Gesture Methods
    
    func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        newImageView.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(GalleryListViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        UIView.animateWithDuration(0.3, animations: {
            newImageView.alpha = 1
            }, completion: nil)
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: {
            (sender.view as! UIImageView).alpha = 0
            }, completion: { _ in
                sender.view?.removeFromSuperview()
        })
    }

}
