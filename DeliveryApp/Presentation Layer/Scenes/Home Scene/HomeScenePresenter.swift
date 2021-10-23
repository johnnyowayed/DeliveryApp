//
//  HomeScenePresenter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol HomeScenePresenter {
    func interactor(didRetreiveOffers offers: HomeSceneModel)
}

final class HomeScenePresenterImplementation {
    weak var viewController: HomeScenePresenterOutput?
}

extension HomeScenePresenterImplementation: HomeScenePresenter {
    func interactor(didRetreiveOffers offersModel: HomeSceneModel) {
        var imageUrls = [URL]()
        let _ = offersModel.offers.map { imageOffer in
            imageUrls.append(URL.init(string: imageOffer.imageUrl)!)
        }
        self.viewController?.presenter(didRetreiveImageUrls: imageUrls)
    }
}
