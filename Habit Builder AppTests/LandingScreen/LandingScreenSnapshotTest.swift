//
//  LandingScreenSnapshotTest.swift
//  Habit Builder AppTests
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import SnapshotTesting
import XCTest

@testable import Habit_Builder_App

class LandingScreenShapshotTest: XCTestCase {
    func testSnapshotLandingScreen() {
        let subject = LandingViewController(viewModel: LandingView.ViewModel(cordinator: MockLandingCordinator()))
        assertSnapshot(matching: subject, as: .image(on: TestConfig.snapshotDeviceSize))
    }
}

class MockLandingCordinator: LandingCordinator {
    var rootCordinator: Habit_Builder_App.RootCordinator?
    
    func start() {
        
    }
}
