//
//  RemoveFridgeIngredientsUseCaseMock.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 21/04/2023.
//

import XCTest
import Foundation
@testable import Reciplease

final class RemoveFridgeIngredientsUseCaseMock: RemoveFridgeIngredientsUseCaseProtocol {
    var mockExpectation: XCTestExpectation?
    var hasError: Bool
    class ExecuteError: Error {}
    let executeError = ExecuteError()
    
    init(hasError: Bool = false) {
        self.hasError = hasError
    }
    
    func execute() async throws {
        switch hasError {
        case false:
            mockExpectation?.fulfill()
        case true:
            throw executeError
        }
    }
}
