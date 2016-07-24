//
//  ImageCollectionViewCell.swift
//  Saint Joseph
//
//  Created by Dharani on 7/23/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    
    weak var delegate: ChooseItem?
}

class VideoCollectionViewCell: ImageCollectionViewCell {
    
    @IBAction private func videoClicked(sender: UIButton) {
            delegate?.chooseSelectedItem(sender.tag)
    }
}

class GalleryCollectionViewCell: ImageCollectionViewCell {
    
}

protocol ChooseItem: class {
    func chooseSelectedItem(tag: Int)
}