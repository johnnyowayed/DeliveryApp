//
//  MenuSceneModel.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit
import Foundation

struct MenuSceneModel: Decodable {
    let menu: [Items]
}

struct Items: Decodable {
    let category: String
    let items: [Item]
}

struct Item: Decodable {
    let name:String
    let imageUrl: String
    let description:String
    let price:String
}
