//
//  MenuSceneRouter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol MenuSceneRouter {
    
}

final class MenuSceneRouterImplementation: NSObject {
    weak var source: UIViewController?
    weak var navigationController: UINavigationController?
}

extension MenuSceneRouterImplementation: MenuSceneRouter {
    
}
