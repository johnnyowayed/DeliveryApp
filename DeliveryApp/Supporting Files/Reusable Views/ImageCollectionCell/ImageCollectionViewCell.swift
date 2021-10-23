//
//  ImageCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Johnny on 23/10/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.contentMode = .scaleAspectFill
        
    }

}
