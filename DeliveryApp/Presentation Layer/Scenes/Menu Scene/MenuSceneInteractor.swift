//
//  MenuSceneInteractor.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import Foundation

protocol MenuSceneInteractor {
    func fetchMenuItems(request: MenuModel.Request?)
}

final class MenuSceneInteractorImplementation {
    var presenter: MenuScenePresenter?
    var worker: MenuSceneWorker?
    var menuItems = [Menu]()
}

extension MenuSceneInteractorImplementation: MenuSceneInteractor {
    
    func fetchMenuItems(request: MenuModel.Request?) {
        
        let _ = worker?.fetchMenu(completion: { response in
            switch response {
            case .success(let menus):
                self.menuItems = menus
                let response = MenuModel.Response(menus: menus)
                self.presenter?.interactor(didReceiveMenus: response)
            case .failure(_):
                print("Failed to fetch data")
            }
        })
    }
}

