//
//  AlamofireService.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import Foundation
import Alamofire

protocol AlamofireServiceProtocol {
    func request(with route: URLRequestConvertible, completion: @escaping (AFDataResponse<Data?>) -> Void)
}

final class AlamofireService: AlamofireServiceProtocol {
    func request(with route: URLRequestConvertible, completion: @escaping (AFDataResponse<Data?>) -> Void) {
        AF.request(route).validate().response { response in
                completion(response)
        }
    }
}
