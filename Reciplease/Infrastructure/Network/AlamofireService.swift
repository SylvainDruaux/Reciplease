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
    
    // Custom session to allow cached url response
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                storagePolicy: .allowed)
        })
        return Session(
          configuration: configuration,
          cachedResponseHandler: responseCacher)
    }()
    
    func request(with route: URLRequestConvertible) async throws -> Data? {
        return try await withCheckedThrowingContinuation { continuation in
            sessionManager.request(route).validate().response { response in
                continuation.resume(with: response.result)
            }
        }
    }
}
