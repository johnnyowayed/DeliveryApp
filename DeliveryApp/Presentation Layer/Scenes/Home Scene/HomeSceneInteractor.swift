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
        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode(HomeSceneModel.self, from: data)
                self.presenter?.interactor(didRetreiveOffers: jsonResult)
                
            } catch {
            }
        }
    }
    
    
}
