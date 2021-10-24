//
//  CartScenePresenter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol CartScenePresenter {
    func interactor(didRemoveItemFromCart newItemList: [Item])
    func interactor(didCalculateTotalPrice newPrice: Int)
}

final class CartScenePresenterImplementation {
    weak var viewController: CartScenePresenterOutput?
}

extension CartScenePresenterImplementation: CartScenePresenter {
    
    func interactor(didCalculateTotalPrice newPrice: Int) {
        self.viewController?.presenter(newPrice: "\(newPrice)" + " " + "usd")
    }
    
    func interactor(didRemoveItemFromCart newItemList: [Item]) {
        self.viewController?.presenter(newItemsInCart: newItemList)
    }
}
