//
//  TableViewCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Johnny on 23/10/2021.
//

import UIKit

class TableViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView:UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

}
