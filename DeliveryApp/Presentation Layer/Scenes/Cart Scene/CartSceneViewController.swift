//
//  CartSceneViewController.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol CartScenePresenterOutput: AnyObject {
    
}

protocol CartSceneViewControllerOutput {}

final class CartSceneViewController: UIViewController {
    var interactor: CartSceneInteractor?
    var router: CartSceneRouter?
    
    var itemsInCart = [Item]()
    
    @IBOutlet weak var tableView:UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupUI()
        self.registerCells()
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

extension CartSceneViewController: CartScenePresenterOutput {
    
}

extension CartSceneViewController: CartSceneViewControllerOutput {
    
}

extension CartSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if (self.itemsInCart.count) >= indexPath.row + 1 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as! CartItemTableViewCell
            cell1.selectionStyle = .none
            let itemInCart = self.itemsInCart[indexPath.row]
            cell1.itemName_Label.text = itemInCart.name
            cell1.itemPrice_Label.text = itemInCart.price
            cell1.itemImage_ImageView.sd_setImage(with: URL(string: itemInCart.imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            cell1.cancelItem_Button.addAction {
                
            }
            return cell1
        }else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TotalPriceTableViewCell
            cell2.selectionStyle = .none
            cell2.delivery_Label.text = "Delivery is free"
            cell2.value_Label.text = "Value:"
            cell2.totalPrice_Label.text = "200 usd"
            return cell2
        }
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
        let router = CartSceneRouterImplementation()
        let worker = CartSceneWorkerImplementation()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
    }
}
