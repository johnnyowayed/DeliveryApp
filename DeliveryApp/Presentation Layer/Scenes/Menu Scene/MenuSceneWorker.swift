//
//  MenuSceneWorker.swift
//  DeliveryApp
//
// Create by Johnny Owayed
//


import Foundation

protocol MenuSceneWorker {
    func fetchMenu(completion: @escaping MenuResponse) -> URLSessionDataTask?
}

typealias MenuResponse = (Result<Menu, Error>) -> Void

final class MenuSceneWorkerImplementation {}

extension MenuSceneWorkerImplementation: MenuSceneWorker {
    func fetchMenu(completion: @escaping MenuResponse) -> URLSessionDataTask? {
        return nil
    }
}

final class MockMenuSceneWorkerImplementation: MenuSceneWorker {
    func fetchMenu(completion: @escaping MenuResponse) -> URLSessionDataTask? {
        if let path = Bundle.main.path(forResource: "menu", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try! JSONDecoder().decode(Menu.self, from: data)
                completion(.success(jsonResult))
            } catch {
            }
        }
        return nil
    }
}



