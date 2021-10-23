//
//  MenuScenePresenter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol MenuScenePresenter {
    func interactor(didReceiveMenu menu: MenuSceneModel)
    func itemsInCart(items: [Item])
}

final class MenuScenePresenterImplementation {
    weak var viewController: MenuScenePresenterOutput?
}

extension MenuScenePresenterImplementation: MenuScenePresenter {
    
    func itemsInCart(items: [Item]) {
        self.viewController?.presenter(newItemsInCart: items)
    }
    
    func interactor(didReceiveMenu menuItems: MenuSceneModel) {
        self.viewController?.presenter(didReceiveMenuModel: menuItems.menu)
    }
}