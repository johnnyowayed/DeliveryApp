//
//  HomeSceneWorker.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//


import Foundation

protocol HomeSceneWorker {
    func fetchImages(completion: @escaping ImagesResponse) -> URLSessionDataTask?
}

typealias ImagesResponse = (Result<HomeSceneModel, Error>) -> Void

final class HomeSceneWorkerImplementation {
    var presenter: HomeScenePresenter?
}

extension HomeSceneWorkerImplementation: HomeSceneWorker {
    func fetchImages(completion: @escaping ImagesResponse) -> URLSessionDataTask? {
        return nil
    }
}

final class MockHomeSceneWorkerImplementation: HomeSceneWorker {
    func fetchImages(completion: @escaping ImagesResponse) -> URLSessionDataTask? {
        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode(HomeSceneModel.self, from: data)
                completion(.success(jsonResult))
            } catch {
            }
        }
        return nil
    }
}
