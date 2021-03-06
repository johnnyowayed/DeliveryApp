//
//  CartSceneInteractor.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import Foundation

protocol CartSceneInteractor {
    func calculateTotalPrice(items: [MenuModel.ViewModel.DisplayedMenu.DisplayedItem])
}

final class CartSceneInteractorImplementation {
    var presenter: CartScenePresenter?
}

extension CartSceneInteractorImplementation: CartSceneInteractor {
    
    func calculateTotalPrice(items: [MenuModel.ViewModel.DisplayedMenu.DisplayedItem]) {
        var totalPrice = 0
        for item in items {
            totalPrice += item.price
        }
        self.presenter?.interactor(didCalculateTotalPrice: totalPrice)
    }
}
