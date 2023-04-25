//
//  AppearanceViewModelTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 23/04/2023.
//

import XCTest
@testable import Reciplease

class AppearanceViewModelTests: XCTestCase {
    func test_initAppearanceViewModel() {
        let viewModel = AppearanceViewModel().cellsViewModel
        XCTAssertEqual(viewModel.count, 3)
        XCTAssertEqual(viewModel[0].name, "Light mode")
        XCTAssertEqual(viewModel[0].style, "light")
        XCTAssertEqual(viewModel[1].name, "Dark mode")
        XCTAssertEqual(viewModel[1].style, "dark")
        XCTAssertEqual(viewModel[2].name, "Use device settings")
        XCTAssertEqual(viewModel[2].style, "unspecified")
    }
}
