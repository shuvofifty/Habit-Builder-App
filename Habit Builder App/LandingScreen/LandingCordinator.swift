//
//  LandingCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/5/23.
//

import Foundation
import Factory
import UIKit

protocol LandingCordinator: Cordinator {
    func navigateToSignUp()
}

class LandingCordinatorImp: LandingCordinator {
    var rootCordinator: RootCordinator
    
    init(rootCordinator: RootCordinator) {
        self.rootCordinator = rootCordinator
    }
    
    func start() {
        
    }
    
    func getWithRouter() -> Router? {
        RouterImp(
            navigationController: UINavigationController(
                rootViewController: LandingViewController(
                    viewModel: Container.shared.landingViewModel()
                )
            )
        )
    }
    
    func navigateToSignUp() {
        rootCordinator.signupCordinator.start()
    }
}
