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

final class RestAPIClient: RestAPIClientProtocol {

    var alamofireService: AlamofireServiceProtocol
    
    init(alamofireService: AlamofireServiceProtocol = AlamofireService()) {
        self.alamofireService = alamofireService
    }
    
    func fetchData<T: Decodable>(route: APIRouter) async throws -> T {
        let result = await alamofireService.request(with: route).result
        switch result {
        case .success(let data):
            guard let data = data else { throw DataError.noData }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch DecodingError.dataCorrupted(let context) {
                fatalError("Data Corrupted or invalid JSON: \(context)")
            } catch DecodingError.keyNotFound(let key, let context) {
                fatalError("Key '\(key.stringValue)' not found: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let value, let context) {
                fatalError("Value '\(value)' not found: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                fatalError("Type '\(type)' mismatch: \(context.debugDescription)")
            } catch {
                throw DataError.decodingError(error)
            }
        case .failure(let error):
            throw DataError.apiError(error.localizedDescription)
        }
    }
        
    func fetchRawData(route: APIRouter) async throws -> Data {
        let result = await alamofireService.request(with: route).result
        switch result {
        case .success(let data):
            guard let data = data else { throw DataError.noData }
            return data
        case .failure(let error):
            throw DataError.apiError(error.localizedDescription)
        }
    }
}
