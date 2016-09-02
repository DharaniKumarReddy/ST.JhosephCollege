//
//  NewsViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit
import CoreData

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ChoosedItemDelegate {

    var news: [NewsData]!
    
    // MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }
    
    // MARK:- UITableView Data Source Methods
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? CollectionViewTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count/2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CollectionViewTableViewCell", forIndexPath: indexPath) as! CollectionViewTableViewCell
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Adjust cell size for orientation
        let width = UIScreen.mainScreen().bounds.width / 2
        return CGSizeMake(width, 134.0)
    }
    
    // MARK:- UICollectionView DataSource Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count - (collectionView.tag * 2) < 2 ? 1 : 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.CellIdentifier.GalleryCollectionViewCell, forIndexPath: indexPath) as! GalleryCollectionViewCell
        cell.delegate = self
        let newsNumber = (collectionView.tag * 1) + (collectionView.tag + indexPath.row)
        let newsObject = news[newsNumber]
        cell.videoButton.tag = newsNumber
        cell.title.text = newsObject.title!
        updateImage(newsObject.largeImageURL!, indexPath: indexPath, collectionView: collectionView)
        return cell
    }
    
    func updateImage(imageIDURL: String, indexPath: NSIndexPath, collectionView: UICollectionView) {
        // We should perform this in a background thread
        //let urlString = "http://img.youtube.com/vi/" + imageID + "/mqdefault.jpg"
        let url = NSURL(string: imageIDURL)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                let image = UIImage(data: data!)
                // Update the cell
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? GalleryCollectionViewCell {
                        cellToUpdate.imageView.image = image
                    }
                })
            }
            else {
                print("Error: \(error!.localizedDescription)")
            }
        })
    }
    
    // MARK:- ChooseItem Method
    
    func chooseSelectedItem(tag: Int, gallery: Bool) {
        let fullNewsViewController = UIStoryboard(Constants.StoryBoard.News).instantiateViewControllerWithIdentifier(Constants.ViewControllerIdentifier.FullNewsViewController) as! FullNewsViewController
        fullNewsViewController.news = news[tag]
        navigationController?.pushViewController(fullNewsViewController, animated: true)
    }
}
