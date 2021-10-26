//
//  HomeSceneModel.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit
import Foundation

enum HomeModel
{
    // MARK: Use cases
    
    struct Request {
    }
    
    struct Response{
        let imageOffers: [ImageOffer]
    }
    
    struct ViewModel {
        var imageUrls: [URL]
    }
}
