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
    case decodingError(Error)
    case apiError(String)
}

final class RestAPIClient {
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
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                case .failure(let error):
                    completion(.failure(.apiError(error.localizedDescription)))
                }
            }
        }
    }
    
    static func fetchRawData(route: APIRouter, completion: @escaping(Result<Data, DataError>) -> Void) {
        AF.request(route).response { response in
            DispatchQueue.main.async {
                let result = response.result
                switch result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.apiError(error.localizedDescription)))
                }
            }
        }
    }
}
