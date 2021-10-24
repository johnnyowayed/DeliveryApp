//
//  MenuSceneRouter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol MenuSceneRouter {
    func goToCart(withItems items: [Item])
}

final class MenuSceneRouterImplementation: NSObject {
    weak var source: UIViewController?
    weak var navigationController: UINavigationController?
}

extension MenuSceneRouterImplementation: MenuSceneRouter {
    
    func goToCart(withItems items: [Item]) {
        let storyboard = UIStoryboard(name: "CartSceneView", bundle: nil)
        let cartSceneVC = storyboard.instantiateViewController(withIdentifier: "CartSceneViewController") as! CartSceneViewController
        cartSceneVC.itemsInCart = items
        self.navigationController?.pushViewController(cartSceneVC, animated: true)
    }
}
