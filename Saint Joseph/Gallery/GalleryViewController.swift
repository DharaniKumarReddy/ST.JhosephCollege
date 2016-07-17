//
//  GalleryViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 7/16/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchGallery()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- API Caller Method
    
    private func fetchGallery() {
        let taskGroup = dispatch_group_create()
        dispatch_group_enter(taskGroup)
        APICaller.getInstance().fetchGallery(
            onSuccessGallery: { newsFeed in
                dispatch_group_leave(taskGroup)
                print(newsFeed)
            }, onError: { _ in
                dispatch_group_leave(taskGroup)
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
        return cell
    }
    
    // MARK: IBAction Methods
    
    @IBAction private func hamburgerPressed(sender: UIBarButtonItem) {
        slidingViewController().anchorTopViewToRightAnimated(true)
    }

}
