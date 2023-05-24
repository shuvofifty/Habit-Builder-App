//
//  Resolver+Dependency.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import Factory

// MARK: - Cordinators
extension Container {
    var rootCordinator: Factory<RootCordinator> {
        self { RootCordinatorImp() }
            .singleton
    }
    
    var landingCordinator: Factory<LandingCordinator> {
        self { LandingCordinatorImp(rootCordinator: Container.shared.rootCordinator()) }
            .singleton
    }
    
    var signUpCordinator: Factory<SignUpCordinator> {
        self { SignUpCordinatorImp(rootCordinator: Container.shared.rootCordinator()) }
            .singleton
    }
}

// MARK: - ViewModels
extension Container {
    var landingViewModel: Factory<LandingView.ViewModel> {
        self { LandingView.ViewModel(cordinator: Container.shared.landingCordinator()) }
    }
    
    var signUpViewModel: Factory<SignUpView.ViewModel> {
        self { SignUpView.ViewModel(cordinator: Container.shared.signUpCordinator()) }
    }
}
