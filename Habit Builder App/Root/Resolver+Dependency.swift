//
//  Resolver+Dependency.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import Factory
import UIKit

// MARK: - Cordinators
extension Container {
    var navigationController: Factory<UINavigationController> {
        self { UINavigationController(rootViewController: Container.shared.rootCordinator().get(for: .landing)) }
            .singleton
    }
    
    var rootCordinator: Factory<Cordinator> {
        self { RootCordinatorImp() }
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

// MARK: - Helpers
extension Container {
    var commonValidators: Factory<CommonValidators> {
        self { CommonValidators() }
            .singleton
    }
    
    var modalHelper: Factory<ModalHelper> {
        self { ModalHelperImp() }
    }
}

// MARK: - Network Helper
extension Container {
    var accountNetworkHelper: Factory<AccountNetworkHelper> {
        self { AccountNetworkHelperImp() }
            .singleton
    }
}
