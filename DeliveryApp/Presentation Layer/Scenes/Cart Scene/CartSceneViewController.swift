//
//  CartSceneViewController.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol CartScenePresenterOutput: AnyObject {
    func presenter(newItemsInCart items: [Item])
    func presenter(newPrice: String)
}

final class CartSceneViewController: UIViewController {
    var interactor: CartSceneInteractor?
    
    var itemsInCart = [Item]()
    var totalPrice = ""
    
    @IBOutlet weak var tableView:UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupUI()
        self.registerCells()
        self.interactor?.calculateTotalPrice(items: self.itemsInCart)
    }
    
    func setupUI() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    
    func registerCells() {
        self.tableView.register(UINib.init(nibName: "TotalPriceTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.tableView.register(UINib.init(nibName: "CartItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell1")
    }
}

//MARK: - Presenter Protocols

extension CartSceneViewController: CartScenePresenterOutput {
    func presenter(newPrice: String) {
        self.totalPrice = newPrice
        self.tableView.reloadData()
    }
    
    func presenter(newItemsInCart items: [Item]) {
        self.itemsInCart = items
        self.interactor?.calculateTotalPrice(items: self.itemsInCart)
        self.tableView.reloadData()
    }
}

//MARK: - TableView Delegate & Data Source

extension CartSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !self.itemsInCart.isEmpty {
            if (self.itemsInCart.count) >= indexPath.row + 1 {
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as! CartItemTableViewCell
                cell1.selectionStyle = .none
                let itemInCart = self.itemsInCart[indexPath.row]
                cell1.itemName_Label.text = itemInCart.name
                cell1.itemPrice_Label.text = "\(itemInCart.price)" + " " + itemInCart.currency
                cell1.itemImage_ImageView.sd_setImage(with: URL(string: itemInCart.imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                cell1.cancelItem_Button.tag = indexPath.row
                cell1.cancelItem_Button.addTarget(self, action: #selector(cancelItem), for: .touchUpInside)
                return cell1
            }else {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TotalPriceTableViewCell
                cell2.selectionStyle = .none
                cell2.delivery_Label.text = "Delivery is free"
                cell2.value_Label.text = "Value:"
                cell2.totalPrice_Label.text = self.totalPrice
                return cell2
            }
        }
        return UITableViewCell()
    }
    
    @objc func cancelItem(sender: UIButton) {
        self.interactor?.removeItemFromList(items: self.itemsInCart, index: sender.tag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInCart.count + 1
    }
}

//MARK: Setup Clean Code Design Pattern

extension CartSceneViewController {
    func setup() {
        let viewController = self
        let interactor = CartSceneInteractorImplementation()
        let presenter = CartScenePresenterImplementation()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
