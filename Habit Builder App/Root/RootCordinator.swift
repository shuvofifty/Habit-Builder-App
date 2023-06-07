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
    var navigationController: UINavigationController? { get set }
    
    func navigate(to screen: Screen)
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID)
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, id: String)
    
    func remove(group id: ScreenGroupID)
    func remove(with viewIDs: [String])
    
    func get(for screen: Screen) -> UIViewController
}

class RootCordinatorImp: Cordinator {
    var navigationController: UINavigationController?
    private var screenGroups: [ScreenGroupID: [String]] = [:]
    
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
        navigationController?.pushViewController(get(for: screen), animated: true)
    }
    
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID) {
        navigate(to: screen, groupWith: groupId, id: UUID().uuidString)
    }
    
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, id: String) {
        guard let vc = get(for: screen) as? IDViewController else {
            fatalError("IDViewController is not set with this")
        }
        if screenGroups[groupId] == nil {
            screenGroups[groupId] = []
        }
        screenGroups[groupId]?.append(id)
        vc.screen_ID = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func remove(group id: ScreenGroupID) {
        guard let ids = screenGroups[id] else {
            return
        }
        remove(with: ids)
        screenGroups.removeValue(forKey: id)
    }
    
    func remove(with viewIDs: [String]) {
        if let navigationController = self.navigationController {
            var viewControllers = navigationController.viewControllers
            viewControllers.removeAll(where: {
                if let idVC = $0 as? IDViewController, let id = idVC.screen_ID {
                    return viewIDs.contains(id)
                }
                return false
            })
            navigationController.setViewControllers(viewControllers, animated: true)
        }
    }
}

extension Cordinator {
    func get(for screen: Screen) -> UIViewController { UIViewController() }
}

enum ScreenGroupID {
    case signIn
}
