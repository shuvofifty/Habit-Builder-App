//
//  LandingCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/5/23.
//

import Foundation
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
                    viewModel: LandingView.ViewModel(cordinator: self)
                )
            )
        )
    }
    
    func navigateToSignUp() {
        rootCordinator.signupCordinator.start()
    }
}
