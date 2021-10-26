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
        
        if UIScreen.main.bounds.height != 736 { // fixing iphone 8 plus
            menuSceneVC.partialView = UIScreen.main.bounds.height * 0.55// 55% of the Screen Size
        }else {
            menuSceneVC.partialView = UIScreen.main.bounds.height * 0.54
        }

        source?.addChild(menuSceneVC)
        source?.view.addSubview(menuSceneVC.view)
        menuSceneVC.didMove(toParent: source)

        let height = (source?.view.frame.height ?? 0) - (self.navigationController?.navigationBar.frame.size.height ?? 0)
        let width = source?.view.frame.width ?? 0
        menuSceneVC.view.frame = CGRect(x: 0, y: source?.view.frame.maxY ?? 0, width: width, height: height)
    }
}
