//
//  MenuSceneViewController.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol MenuScenePresenterOutput: AnyObject {
    func presenter(didReceiveMenuModel menuItems: [Items])
    func presenter(newItemsInCart items: [Item])
}

final class MenuSceneViewController: UIViewController, UIGestureRecognizerDelegate {
    var interactor: MenuSceneInteractor?
    var router: MenuSceneRouter?
    
    var menuItems = [Items]()
    var itemsInCart = [Item]()
    
    let fullView: CGFloat = 50 // this view's y origin case full view (bottom sheet expanded)
    var partialView = CGFloat() // the view's y origin case partial view (bottom sheet collapsed)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl:UISegmentedControl!
    
    var tableView: UITableView!
    
    var floatingButton = UIButton(type: .custom)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupUI()
        self.setupSegmentControl()
        self.registerCell()
        self.fixBackgroundSegmentControl()
        self.interactor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.floatingButton.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame.origin.y = yComponent!
            self?.view.frame.size.width = frame!.width
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 0.1
        view.layer.borderColor = UIColor.white.cgColor
        view?.layer.masksToBounds = false
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view?.layer.shadowRadius = 35
        view?.layer.shadowOpacity = 1.0
    }

    func setupUI() {
        
        self.title = "Menu"
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: width, height: partialView + 50)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView?.collectionViewLayout = flowLayout
        self.collectionView.isPagingEnabled = true
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        gesture.delegate = self
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    func registerCell() {
        self.collectionView.register(UINib.init(nibName: "TableViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
}

//MARK: - Presenter Protocols

extension MenuSceneViewController: MenuScenePresenterOutput {

    func presenter(newItemsInCart items: [Item]) {
        self.itemsInCart = items
    }
    
    func presenter(didReceiveMenuModel menuItems: [Items]) {
        self.menuItems = menuItems
        self.collectionView.reloadData()
    }
}

//MARK: - CollectionView Delegate & DataSource

extension MenuSceneViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! TableViewCollectionViewCell

        cell.tableView.delegate = self
        cell.tableView.dataSource = self
        cell.tableView.tag = indexPath.row
        cell.tableView.register(UINib.init(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.tableView = cell.tableView

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.segmentControl.selectedSegmentIndex = indexPath.row
    }
}

//MARK: - TableView Delegates & DataSource

extension MenuSceneViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! MenuItemTableViewCell
        cell.selectionStyle = .none
        let menuItem = self.menuItems[tableView.tag].items[indexPath.row]
        cell.title_Label.text = menuItem.name
        cell.desciption_Label.text = menuItem.description
        let imageUrl = URL.init(string: menuItem.imageUrl)
        cell.itemImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder.png"))
        cell.button.setTitle(menuItem.price, for: .normal)
        cell.button.addAction {
            if cell.button.backgroundColor == .black {
                let index = IndexPath.init(row: indexPath.row, section: tableView.tag)
                self.interactor?.didAddItemToCartAt(oldItems: self.itemsInCart, index: index)
                cell.button.backgroundColor = .green
                cell.button.setTitle("Added +1", for: .normal)
            }else {
                let index = IndexPath.init(row: indexPath.row, section: tableView.tag)
                self.interactor?.didRemoveItemFromCartAt(oldItems: self.itemsInCart, index: index)
                cell.button.backgroundColor = .black
                cell.button.setTitle(menuItem.price, for: .normal)
            }
            print("Items in cart: \(self.itemsInCart)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems[tableView.tag].items.count
    }
}

//MARK: - Setup Segment Control

extension MenuSceneViewController {
    
    func setupSegmentControl() {
        segmentControl.setTitle("Pizza", forSegmentAt: 0)
        segmentControl.setTitle("Sushi", forSegmentAt: 1)
        segmentControl.setTitle("Drinks", forSegmentAt: 2)
        
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.backgroundColor = .clear
        segmentControl.tintColor = .clear
        segmentControl.selectedSegmentTintColor = .clear
        
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: .left, animated: true)
        case 1:
            self.collectionView.scrollToItem(at: IndexPath.init(item: 1, section: 0), at: .left, animated: true)
        case 2:
            self.collectionView.scrollToItem(at: IndexPath.init(item: 2, section: 0), at: .left, animated: true)
        default:
            return
        }
    }
    
    // To Solve iOS 13 segement control background color issue
    func fixBackgroundSegmentControl(){
        if #available(iOS 13.0, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(self.segmentControl.numberOfSegments-1)  {
                    let backgroundSegmentView = self.segmentControl.subviews[i]
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
}

//MARK: - Setup Clean Code Design Pattern

extension MenuSceneViewController {
    func setup() {
        let viewController = self
        let interactor = MenuSceneInteractorImplementation()
        let presenter = MenuScenePresenterImplementation()
        let router = MenuSceneRouterImplementation()
        let worker = MockMenuSceneWorkerImplementation()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
    }
}

//MARK: - Bottomsheet Animation
extension MenuSceneViewController {
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)

        let y = view.frame.minY
        if y + translation.y >= fullView, y + translation.y <= partialView {
            view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
            self.createFloatingButton()
        }
        
        if recognizer.state == .ended {
            var duration = velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y)

            duration = duration > 1.3 ? 1 : duration

            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                    self.floatingButton.removeFromSuperview()
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }

            }, completion: { [weak self] _ in
                if velocity.y < 0 {
                    self?.tableView.isScrollEnabled = true
                }
            })
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y

        let y = view.frame.minY
        
        if (y == partialView && direction < 0) {
            self.tableView.isScrollEnabled = false
        } else {
            self.tableView.isScrollEnabled = true
        }

        return false
    }
}

//MARK: - Creating a Floating Button

extension MenuSceneViewController {
    
    func createFloatingButton() {
        
        floatingButton.frame = CGRect(x: 300, y: 700, width: 60, height: 60)
        floatingButton.setImage(UIImage.init(named: "ic-shopping-cart"), for: .normal)
        floatingButton.isUserInteractionEnabled = true
        floatingButton.backgroundColor = .white
        floatingButton.layer.masksToBounds = false
        floatingButton.layer.cornerRadius = floatingButton.frame.height/2
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowPath = UIBezierPath(roundedRect: floatingButton.bounds, cornerRadius: floatingButton.layer.cornerRadius).cgPath
        floatingButton.layer.shadowOffset = CGSize(width: 1, height: 3.0)
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.layer.shadowRadius = 1.0
        floatingButton.addTarget(self,action:#selector(buttonClicked), for: .touchUpInside)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(floatingButton)
        }
    }
    
    @objc func buttonClicked(sender:UIButton) {
        self.floatingButton.setImage(UIImage.init(named: "ic-credit-card"), for: .normal)
        self.floatingButton.isUserInteractionEnabled = false
        self.router?.goToCart(withItems: self.itemsInCart)
    }
}

