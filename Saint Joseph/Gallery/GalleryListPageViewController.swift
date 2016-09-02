//
//  GalleryListPageViewController.swift
//  Saint Joseph
//
//  Created by Dharani on 9/2/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class GalleryListPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var images: [UIImage]!
    
    private var index: Int!
    
    private var galleryPageViewController: [GalleryPageViewController] = []
    
    func configure(images: [UIImage], index: Int) {
        self.index = index
        self.images = images
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for image in images {
            appendDataViewControllerForImage(image)
        }
        
        setViewControllerAtIndex(index)

        if galleryPageViewController.count == 1 {
            dataSource = nil
        }
        // Do any additional setup after loading the view.
    }
    
    func setViewControllerAtIndex(newIndex: Int) {
        let galleryPageController = galleryPageViewController[newIndex]
        
        if !viewControllers!.isEmpty {
            let direction: UIPageViewControllerNavigationDirection = newIndex < indexOfCurrentViewController() ? .Reverse : .Forward
            setViewControllers([galleryPageController], direction: direction, animated: true)
        } else {
            setViewControllers([galleryPageController], direction: .Forward, animated: false)
        }
    }
    
    private func appendDataViewControllerForImage(image: UIImage) {
        let galleryPageController = UIStoryboard(Constants.StoryBoard.Gallery).instantiateViewControllerWithIdentifier(Constants.ViewControllerIdentifier.GalleryPageViewController) as! GalleryPageViewController
        galleryPageController.image = image
        galleryPageViewController.append(galleryPageController)
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return viewControllerAtIndex(indexOfViewController(viewController as! GalleryPageViewController) - 1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return viewControllerAtIndex(indexOfViewController(viewController as! GalleryPageViewController) + 1)
    }
    
    private func viewControllerAtIndex(index: Int) -> GalleryPageViewController? {
        if index == -1 || index == galleryPageViewController.count {
            return nil
        }
        return galleryPageViewController[index]
    }
    
    // MARK: UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            //parentPageControl.currentPage = indexOfCurrentViewController()
        }
    }
    
    private func indexOfCurrentViewController() -> Int {
        return indexOfViewController(viewControllers!.first as! GalleryPageViewController)
    }
    
    private func indexOfViewController(viewController: GalleryPageViewController) -> Int {
        return galleryPageViewController.indexOf(viewController)!
    }

}

extension UIPageViewController {
    func setViewControllers(viewControllers: [UIViewController], direction: UIPageViewControllerNavigationDirection = .Forward, animated: Bool = false) {
        setViewControllers(viewControllers, direction: direction, animated: animated, completion: nil)
    }
}