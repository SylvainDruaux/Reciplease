//
//  SettingsViewModelTests.swift
//  RecipleaseTests
//
//  Created by Sylvain Druaux on 23/04/2023.
//

import XCTest
@testable import Reciplease

class SettingsViewModelTests: XCTestCase {
    let userInterfaceStyle = UserPreferences.userInterfaceStyle
    override func tearDown() {
        super.tearDown()
        UserPreferences.userInterfaceStyle = userInterfaceStyle
    }
    
    func test_SettingsDevice() {
        UserPreferences.userInterfaceStyle = "unspecified"
        let viewModel = SettingViewModel().cellsViewModel
        XCTAssertEqual(viewModel.count, 2)
        XCTAssertEqual(viewModel[0].title, "About")
        XCTAssertNil(viewModel[0].details)
        XCTAssertEqual(viewModel[0].icon, "info.circle.fill")
        XCTAssertEqual(viewModel[1].title, "Appearance")
        XCTAssertEqual(viewModel[1].details, "Use device settings")
        XCTAssertEqual(viewModel[1].icon, "square.lefthalf.filled")
    }
    
    func test_SettingsLightMode() {
        UserPreferences.userInterfaceStyle = "light"
        let viewModel = SettingViewModel().cellsViewModel
        XCTAssertEqual(viewModel.count, 2)
        XCTAssertEqual(viewModel[0].title, "About")
        XCTAssertNil(viewModel[0].details)
        XCTAssertEqual(viewModel[0].icon, "info.circle.fill")
        XCTAssertEqual(viewModel[1].title, "Appearance")
        XCTAssertEqual(viewModel[1].details, "Light mode")
        XCTAssertEqual(viewModel[1].icon, "sun.min.fill")
    }
    
    func test_SettingsDarkMode() {
        UserPreferences.userInterfaceStyle = "dark"
        let viewModel = SettingViewModel().cellsViewModel
        XCTAssertEqual(viewModel.count, 2)
        XCTAssertEqual(viewModel[0].title, "About")
        XCTAssertNil(viewModel[0].details)
        XCTAssertEqual(viewModel[0].icon, "info.circle.fill")
        XCTAssertEqual(viewModel[1].title, "Appearance")
        XCTAssertEqual(viewModel[1].details, "Dark mode")
        XCTAssertEqual(viewModel[1].icon, "moon.fill")
    }
}
