//
//  MenuSceneModel.swift
//  DeliveryApp
//
//  Created by Johnny on 25/10/2021.
//

import Foundation

enum MenuModel
{
    // MARK: Use cases
    
    struct Request {
    }
    
    struct Response{
        let menus: [Menu]
    }
    
    struct ViewModel
    {
        struct DisplayedMenu {
            let category: String
            let items: [DisplayedItem]
            
            struct DisplayedItem: Equatable {
                let name:String
                let imageUrl: String
                let description:String
                let price:Int
                let currency:String
            }
        }
        var menus: [DisplayedMenu]
    }
}
