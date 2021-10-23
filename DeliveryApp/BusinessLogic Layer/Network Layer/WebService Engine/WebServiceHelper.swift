//
//  WebServiceHelper.swift
//  DeliveryApp
//
//  Created by Johnny on 23/10/2021.
//

import Foundation

enum NetworkError: Error {
    case incorrectData(Data)
    case incorrectURL
    case unknown
}

typealias WebServiceCompletionBlock = (Result<Data, Error>) -> Void

struct WebserviceHelper {
    
    @discardableResult public static func requestAPI(apiModel: APIModelType, completion: @escaping WebServiceCompletionBlock) -> URLSessionDataTask? {
        let escapedAddress = (apiModel.api.apiBasePath()+apiModel.api.apiEndPath()).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        request.httpMethod = apiModel.api.httpMthodType().rawValue
        request.allHTTPHeaderFields = WebserviceConfig().generateHeader()

        if let params = apiModel.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknown))
                return
            }

            if let httpStatus = response as? HTTPURLResponse,  ![200, 201].contains(httpStatus.statusCode) {
                completion(.failure(NetworkError.incorrectData(data)))
            }
            completion(.success(data))

        }
        
        task.resume()
        return task
    }

}
