//
//  CartSceneInteractor.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import Foundation

protocol CartSceneInteractor {}

final class CartSceneInteractorImplementation {
    var presenter: CartScenePresenter?
    var worker: CartSceneWorker?
}

extension CartSceneInteractorImplementation: CartSceneInteractor {
    
}
