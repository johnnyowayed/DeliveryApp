//
//  HomeSceneInteractor.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//

import Foundation

protocol HomeSceneInteractor {
    func viewDidLoad()
}

final class HomeSceneInteractorImplementation {
    var presenter: HomeScenePresenter?
    var worker: HomeSceneWorker?
}

extension HomeSceneInteractorImplementation: HomeSceneInteractor {
    func viewDidLoad() {
        let _ = worker?.fetchImages(completion: { response in
            switch response {
            case .success(let homeSceneModel):
                self.presenter?.interactor(didRetreiveOffers: homeSceneModel)
            case .failure(_):
                print("Failed to fetch data")
            }
        })
    }
}
