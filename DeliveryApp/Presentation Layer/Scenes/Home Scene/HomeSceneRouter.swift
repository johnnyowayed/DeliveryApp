//
//  HomeSceneRouter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol HomeSceneRouter {
    func setupBottomSheet()
}

final class HomeSceneRouterImplementation: NSObject {
    weak var source: UIViewController?
    weak var navigationController: UINavigationController?
}

extension HomeSceneRouterImplementation: HomeSceneRouter {
    
    func setupBottomSheet() {
        let storyboard = UIStoryboard(name: "MenuSceneView", bundle: nil)
        let menuSceneVC = storyboard.instantiateViewController(withIdentifier: "MenuSceneViewController") as! MenuSceneViewController
        menuSceneVC.partialView = 550

        source?.addChild(menuSceneVC)
        source?.view.addSubview(menuSceneVC.view)
        menuSceneVC.didMove(toParent: source)

        let height = (source?.view.frame.height ?? 0) - (self.navigationController?.navigationBar.frame.size.height ?? 0)
        let width = source?.view.frame.width ?? 0
        menuSceneVC.view.frame = CGRect(x: 0, y: source?.view.frame.maxY ?? 0, width: width, height: height)
    }
}
