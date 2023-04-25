//
//  FetchRecipeImageUseCaseMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 21/04/2023.
//

import Foundation
@testable import Reciplease

final class FetchRecipeImageUseCaseMock: FetchRecipeImageUseCaseProtocol {
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func execute(url: String) async throws -> Data {
        switch hasError {
        case false:
            return Data()
        case true:
            throw executeError
        }
    }
}
