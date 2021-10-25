//
//  MenuCategories.swift
//  DeliveryApp
//
//  Created by Johnny on 24/10/2021.
//

import Foundation

struct Menu: Decodable {
    let category: String
    let items: [Item]
}

struct Item: Decodable, Equatable {
    let name:String
    let imageUrl: String
    let description:String
    let price:Int
    let currency:String
}
