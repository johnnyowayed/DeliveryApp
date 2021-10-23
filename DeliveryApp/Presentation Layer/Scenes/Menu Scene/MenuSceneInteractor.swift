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
        
//        if let index = items.firstIndex(of: itemTobeRemove) {
//            items.remove(at: index)
//        }
        self.presenter?.itemsInCart(items: items)
    }
    
    func didAddItemToCartAt(oldItems: [Item], index: IndexPath) {
        var items = oldItems
        let newItem = menuItems[index.section].items[index.row]
        items.append(newItem)
        self.presenter?.itemsInCart(items: items)
    }
    
    func viewDidLoad() {
        if let path = Bundle.main.path(forResource: "menu", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode(MenuSceneModel.self, from: data)
                self.menuItems = jsonResult.menu
                self.presenter?.interactor(didReceiveMenu: jsonResult)
                
            } catch {
            }
        }
    }
}
