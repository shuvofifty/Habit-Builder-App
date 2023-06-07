//
//  RootCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/4/23.
//

import Foundation
import Factory
import UIKit

enum Screen {
    case landing, signUp, onboarding
}

protocol Cordinator {
    var router: Router? { get set }
    
    func navigate(to screen: Screen)
    func get(for screen: Screen) -> UIViewController
}

class RootCordinatorImp: Cordinator {
    var router: Router?
    
    func get(for screen: Screen) -> UIViewController {
        switch screen {
        case .landing:
            return LandingViewController(viewModel: Container.shared.landingViewModel())
        case .signUp:
            return SignUpViewController(viewModel: Container.shared.signUpViewModel())
        case .onboarding:
            return OnboardingViewController(viewModel: Container.shared.onboardingViewModel())
        }
    }
    
    func navigate(to screen: Screen) {
        router?.push(get(for: screen), animated: true)
    }
}

extension Cordinator {
    func get(for screen: Screen) -> UIViewController { UIViewController() }
}
