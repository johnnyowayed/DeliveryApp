//
//  HomeScenePresenter.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import UIKit

protocol HomeScenePresenter {
    func interactor(didRetreiveOffers response: HomeModel.Response)
}

final class HomeScenePresenterImplementation {
    weak var viewController: HomeScenePresenterOutput?
}

extension HomeScenePresenterImplementation: HomeScenePresenter {
    func interactor(didRetreiveOffers response: HomeModel.Response) {
        
        var imageUrls = [URL]()
        
        let _ = response.imageOffers.map { imageOffer in
            imageUrls.append(URL.init(string: imageOffer.imageOffer)!)
        }
        let viewModel = HomeModel.ViewModel(imageUrls: imageUrls)
        self.viewController?.didReceiveImageOffers(viewModel: viewModel)
    }
}
