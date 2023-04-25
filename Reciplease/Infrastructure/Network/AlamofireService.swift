//
//  AlamofireService.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import Foundation
import Alamofire

protocol AlamofireServiceProtocol {
    func request(with route: URLRequestConvertible) async throws -> Data?
}

final class AlamofireService: AlamofireServiceProtocol {
    func request(with route: URLRequestConvertible) async throws -> Data? {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(route).validate().response { response in
                continuation.resume(with: response.result)
            }
        }
    }
}
