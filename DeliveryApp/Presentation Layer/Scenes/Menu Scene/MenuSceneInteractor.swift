//
//  MenuSceneInteractor.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import Foundation

protocol MenuSceneInteractor {
    func viewDidLoad()
    func didAddItemToCartAt(oldItems: [Item], index: IndexPath)
    func didRemoveItemFromCartAt(oldItems: [Item], index: IndexPath)
}

final class MenuSceneInteractorImplementation {
    var presenter: MenuScenePresenter?
    var worker: MenuSceneWorker?
    var menuItems = [Items]()
}

extension MenuSceneInteractorImplementation: MenuSceneInteractor {
    func didRemoveItemFromCartAt(oldItems: [Item], index: IndexPath) {
        var items = oldItems
        let itemTobeRemove =  menuItems[index.section].items[index.row]
        
        
        items.removeAll { $0 == itemTobeRemove}

        self.presenter?.itemsInCart(items: items)
    }
    
    func didAddItemToCartAt(oldItems: [Item], index: IndexPath) {
        var items = oldItems
        let newItem = menuItems[index.section].items[index.row]
        items.append(newItem)
        self.presenter?.itemsInCart(items: items)
    }
    
    func viewDidLoad() {
        
        let _ = worker?.fetchMenu(completion: { response in
            switch response {
            case .success(let homeSceneModel):
                self.menuItems = homeSceneModel.menu
                self.presenter?.interactor(didReceiveMenu: homeSceneModel)
            case .failure(_):
                print("Failed to fetch data")
            }
        })
    }
}

