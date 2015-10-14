//
//  ThumbnailCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/8/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class HeaderCollectionView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
}

class FooterCollectionView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
}
