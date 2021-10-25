//
//  MenuScenePresenter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol MenuScenePresenter {
    func interactor(didReceiveMenus response: MenuModel.Response)
}

final class MenuScenePresenterImplementation {
    weak var viewController: MenuScenePresenterOutput?
}

extension MenuScenePresenterImplementation: MenuScenePresenter {

    func interactor(didReceiveMenus response: MenuModel.Response) {
        
        var displayedMenus: [MenuModel.ViewModel.DisplayedMenu] = []
        
        for menu in response.menus {
            var displayedItems: [MenuModel.ViewModel.DisplayedMenu.DisplayedItem] = []
            for item in menu.items {
                let displayedItem = MenuModel.ViewModel.DisplayedMenu.DisplayedItem(name: item.name, imageUrl: item.imageUrl, description: item.description, price: item.price, currency: item.currency)
                displayedItems.append(displayedItem)
            }
            
            let displayedMenu = MenuModel.ViewModel.DisplayedMenu(category: menu.category, items: displayedItems)
            
            displayedMenus.append(displayedMenu)
        }
        
        let viewModel = MenuModel.ViewModel(menus: displayedMenus)
        
        self.viewController?.presenter(didReceiveMenus: viewModel)
    }
}
