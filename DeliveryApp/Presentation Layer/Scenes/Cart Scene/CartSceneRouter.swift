//
//  CartSceneRouter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol CartSceneRouter {
    
}

final class CartSceneRouterImplementation: NSObject {
    weak var source: UIViewController?
    weak var navigationController: UINavigationController?
}

extension CartSceneRouterImplementation: CartSceneRouter {
    
}
