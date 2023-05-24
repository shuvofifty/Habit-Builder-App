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
    var rootCordinator: Factory<Cordinator> {
        self { RootCordinatorImp() }
            .singleton
    }
    
    var landingCordinator: Factory<LandingCordinator> {
        self { LandingCordinatorImp() }
            .singleton
    }
    
    var onboardingCordinator: Factory<OnboardingCordinator> {
        self { OnboardingCordinatorImp() }
            .singleton
    }
}

// MARK: - ViewModels
extension Container {
    var landingViewModel: Factory<LandingView.ViewModel> {
        self { LandingView.ViewModel() }
    }
    
    var signUpViewModel: Factory<SignUpView.ViewModel> {
        self { SignUpView.ViewModel() }
    }
    
    var onboardingViewModel: Factory<OnboardingView.ViewModel> {
        self { OnboardingView.ViewModel() }
    }
}
