//
//  CartItemTableViewCell.swift
//  DeliveryApp
//
//  Created by Johnny on 24/10/2021.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage_ImageView:UIImageView!
    @IBOutlet weak var itemName_Label:UILabel!
    @IBOutlet weak var itemPrice_Label:UILabel!
    @IBOutlet weak var cancelItem_Button:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.cancelItem_Button.layer.cornerRadius = self.cancelItem_Button.bounds.height/2
        self.cancelItem_Button.layer.masksToBounds = true
        self.cancelItem_Button.setTitle("", for: .normal)
        self.cancelItem_Button.setImage(UIImage.init(named: "ic-close"), for: .normal)
        self.cancelItem_Button.backgroundColor = .lightGray
    }
}
