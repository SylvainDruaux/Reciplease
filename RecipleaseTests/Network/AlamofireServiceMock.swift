//
//  AlamofireServiceMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 12/04/2023.
//

import Foundation
import Alamofire
@testable import Reciplease

struct ResponseMock {
    var response: HTTPURLResponse?
    var data: Data?
}

final class AlamofireServiceMock: AlamofireServiceProtocol {
    private let responseMock: ResponseMock
    
    init(responseMock: ResponseMock) {
        self.responseMock = responseMock
    }
    
    func request(with route: URLRequestConvertible) async throws -> Data? {
        return try await withCheckedThrowingContinuation { continuation in
            let statusCode = responseMock.response?.statusCode
            let response = AFDataResponse<Data?>(request: nil,
                                                 response: responseMock.response,
                                                 data: responseMock.data, metrics: nil,
                                                 serializationDuration: 0,
                                                 result: statusCode == 200 ? .success(responseMock.data) : .failure(.explicitlyCancelled)
            )
            continuation.resume(with: response.result)
        }
    }
}
