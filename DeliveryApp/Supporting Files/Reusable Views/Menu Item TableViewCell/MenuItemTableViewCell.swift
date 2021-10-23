//
//  MenuItemTableViewCell.swift
//  DeliveryApp
//
//  Created by Johnny on 23/10/2021.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title_Label: UILabel!
    @IBOutlet weak var desciption_Label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var outerView: UIView!
    
    var isOn:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        
        self.outerView.layer.cornerRadius = 24
        self.outerView.layer.masksToBounds = true
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView .layer.shadowRadius = 10
        
        self.title_Label.font = UIFont.boldSystemFont(ofSize: 30)
        self.desciption_Label.font = UIFont.systemFont(ofSize: 14)
        self.desciption_Label.textColor = .lightGray
        
        self.button.layer.cornerRadius = self.button.bounds.height/2
        self.button.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
