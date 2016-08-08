//
//  FullNewsViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 8/7/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class FullNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var news: NewsData!

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier.FullNewsTableCell) as! FullNewsTableCell
        updateImage(news.largeImageURL!, indexPath: indexPath, tableView: tableView)
        cell.descriptionLabel.text = news.descript
        return cell
    }

    func updateImage(imageURL: String, indexPath: NSIndexPath, tableView: UITableView) {
        // We should perform this in a background thread
        let url = NSURL(string: imageURL)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                let image = UIImage(data: data!)
                // Update the cell
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as? FullNewsTableCell {
                        cellToUpdate.newsImageView.image = image
                    }
                })
            }
            else {
                print("Error: \(error!.localizedDescription)")
            }
        })
    }
}

class FullNewsTableCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
}