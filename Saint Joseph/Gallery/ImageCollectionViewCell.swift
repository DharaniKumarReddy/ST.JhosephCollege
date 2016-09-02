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
    
    weak var delegate: ChoosedItemDelegate?
}

class VideoCollectionViewCell: ImageCollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBAction private func videoClicked(sender: UIButton) {
            delegate?.chooseSelectedItem(sender.tag, gallery: true)
    }
}

class GalleryCollectionViewCell: ImageCollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBAction private func imageClicked(sender: UIButton) {
        delegate?.chooseSelectedItem(sender.tag, gallery: true)
    }
}

protocol ChoosedItemDelegate: class {
    func chooseSelectedItem(tag: Int, gallery: Bool)
}