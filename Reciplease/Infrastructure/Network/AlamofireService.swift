//
//  AlamofireService.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import Foundation
import Alamofire

protocol AlamofireServiceProtocol {
    func request(with route: URLRequestConvertible) async -> AFDataResponse<Data?>
}

final class AlamofireService: AlamofireServiceProtocol {
    func request(with route: URLRequestConvertible) async -> AFDataResponse<Data?> {
        return await withCheckedContinuation { continuation in
            AF.request(route).validate().response { response in
                continuation.resume(returning: response)
            }
        }
    }
}
