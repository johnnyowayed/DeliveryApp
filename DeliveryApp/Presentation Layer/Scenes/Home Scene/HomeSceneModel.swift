//
//  HomeSceneModel.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit
import Foundation

struct HomeSceneModel: Decodable {
    let offers: [imageOffer]
}

struct imageOffer: Decodable {
    let imageUrl: String
}
