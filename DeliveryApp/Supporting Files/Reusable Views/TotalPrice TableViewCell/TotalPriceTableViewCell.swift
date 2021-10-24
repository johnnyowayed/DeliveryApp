//
//  TotalPriceTableViewCell.swift
//  DeliveryApp
//
//  Created by Johnny on 24/10/2021.
//

import UIKit

class TotalPriceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var delivery_Label: UILabel!
    @IBOutlet weak var value_Label: UILabel!
    @IBOutlet weak var totalPrice_Label: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.delivery_Label.font = .systemFont(ofSize: 16)
        self.delivery_Label.textColor = .lightGray
        
        self.value_Label.font = .systemFont(ofSize: 16)
        self.value_Label.textColor = .black
        
        self.totalPrice_Label.font = .boldSystemFont(ofSize: 30)
        self.totalPrice_Label.textColor = .black
        
    }
    
}
