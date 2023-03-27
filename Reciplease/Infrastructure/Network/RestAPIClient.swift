//
//  RestAPIClient.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 17/03/2023.
//

import Foundation
import Alamofire

enum DataError: Error {
    case noData
    case decodingError
    case apiError(String)
}

class RestAPIClient {
    static func fetchData<T: Decodable>(route: APIRouter, completion: @escaping(Result<T, DataError>) -> Void) {
        AF.request(route).response { response in
            DispatchQueue.main.async {
                let result = response.result
                switch result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                        completion(.failure(.decodingError))
                        return
                    }
                    completion(.success(decodedData))
                case .failure(let error):
                    completion(.failure(.apiError(error.localizedDescription)))
                }
            }
        }
    }
}
