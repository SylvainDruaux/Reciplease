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
    case decodingError(String)
    case apiError(String)
}

final class RestAPIClient: RestAPIClientProtocol {

    var alamofireService: AlamofireServiceProtocol
    
    init(alamofireService: AlamofireServiceProtocol = AlamofireService()) {
        self.alamofireService = alamofireService
    }
    
    func fetchData<T: Decodable>(route: APIRouter) async throws -> T {
        do {
            let data = try await alamofireService.request(with: route)
            guard let data = data else { throw DataError.noData }
            return try JSONDecoder().decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            throw DataError.decodingError("Data Corrupted or invalid JSON: \(context)")
        } catch {
            throw DataError.apiError(error.localizedDescription)
        }
    }
    
    func fetchRawData(route: APIRouter) async throws -> Data {
        do {
            let data = try await alamofireService.request(with: route)
            guard let data = data else { throw DataError.noData }
            return data
        } catch {
            throw DataError.apiError(error.localizedDescription)
        }
    }
}
