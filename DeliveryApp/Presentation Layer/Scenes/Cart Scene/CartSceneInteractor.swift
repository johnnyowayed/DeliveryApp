//
//  CartSceneInteractor.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import Foundation

protocol CartSceneInteractor {
    func removeItemFromList(items: [Item], index: Int)
    func calculateTotalPrice(items: [Item])
}

final class CartSceneInteractorImplementation {
    var presenter: CartScenePresenter?
}

extension CartSceneInteractorImplementation: CartSceneInteractor {
    
    func calculateTotalPrice(items: [Item]) {
        var totalPrice = 0
        for item in items {
            totalPrice += item.price
        }
        self.presenter?.interactor(didCalculateTotalPrice: totalPrice)
    }
    
    func removeItemFromList(items: [Item], index: Int) {
        var newItems = items
        newItems.remove(at: index)
        self.presenter?.interactor(didRemoveItemFromCart: newItems)
    }
}
