//
//  RootCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/4/23.
//

import Foundation
import Factory
import UIKit
import SwiftUI
import Combine

enum Screen {
    case landing, signUp, onboarding, signIn, home
}

protocol Cordinator {
    var navHandler: NavHandler { get }
    
    func navigate(to screen: Screen, transition: TransitionStyle)
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, transition: TransitionStyle)
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, id: String, transition: TransitionStyle)
    
    func remove(group id: ScreenGroupID)
    
    func get(for screen: Screen) -> UIViewController
}

class RootCordinatorImp: NSObject, Cordinator {
    @Injected(\.navHandler) var navHandler: NavHandler
    @Injected(\.tabHandler) var tabHandler: TabHandler
    
    private var screenGroups: [ScreenGroupID: [String]] = [:]
    
    func get(for screen: Screen) -> UIViewController {
        switch screen {
        case .landing:
            return LandingViewController(viewModel: Container.shared.landingViewModel())
        case .signUp:
            return SignUpViewController(viewModel: Container.shared.signUpViewModel())
        case .signIn:
            return SignInViewController(viewModel: Container.shared.signInViewModel())
        case .onboarding:
            return OnboardingViewController(viewModel: Container.shared.onboardingViewModel())
        case .home:
            return HomeViewController(viewModel: Container.shared.homeViewModel())
        }
    }
    
    func navigate(to screen: Screen, transition: TransitionStyle) {
        performNavigation(vc: get(for: screen), transition: transition, screen: screen)
    }
    
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, transition: TransitionStyle) {
        navigate(to: screen, groupWith: groupId, id: UUID().uuidString, transition: transition)
    }
    
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, id: String, transition: TransitionStyle) {
        guard let vc = get(for: screen) as? IDViewController else {
            fatalError("IDViewController is not set with this")
        }
        if screenGroups[groupId] == nil {
            screenGroups[groupId] = []
        }
        screenGroups[groupId]?.append(id)
        vc.screen_ID = id
        performNavigation(vc: vc, transition: transition, screen: screen)
    }
    
    private func performNavigation(vc: UIViewController, transition: TransitionStyle, screen: Screen) {
        let navController = navHandler.getNavController(for: screen)
        switch transition {
        case .push:
            navController.pushViewController(vc, animated: true)
        case .fadeIn:
            navController.delegate = self
            navController.pushViewController(vc, animated: true)
        case .present:
            navController.present(vc, animated: true)
        }
        
    }
    
    func remove(group id: ScreenGroupID) {
        guard let ids = screenGroups[id] else {
            return
        }
        remove(with: ids, navigationController: getNavForScreenGroup(id))
        screenGroups.removeValue(forKey: id)
    }
    
    private func getNavForScreenGroup(_ id: ScreenGroupID) -> UINavigationController {
        switch id {
        case .onBoarding:
            return navHandler.getNavController(for: .landing)
        }
    }
    
    private func remove(with viewIDs: [String], navigationController: UINavigationController) {
        var viewControllers = navigationController.viewControllers
        viewControllers.removeAll(where: {
            if let id = ($0 as? IDViewController)?.screen_ID {
                return viewIDs.contains(id)
            }
            return false
        })
        navigationController.setViewControllers(viewControllers, animated: true)
    }
}

extension RootCordinatorImp: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            let transition = FadeInTransition()
            transition.navController = navigationController
            return transition
        default:
            return nil
        }
    }
}

enum ScreenGroupID {
    case onBoarding
}
