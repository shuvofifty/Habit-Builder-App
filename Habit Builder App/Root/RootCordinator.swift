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
    case landing, signUp, onboarding
}

protocol Cordinator {
    var navigationController: UINavigationController? { get set }
    
    func navigate(to screen: Screen, transition: TransitionStyle)
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, transition: TransitionStyle)
    func navigate(to screen: Screen, groupWith groupId: ScreenGroupID, id: String, transition: TransitionStyle)
    
    func remove(group id: ScreenGroupID)
    func remove(with viewIDs: [String])
    
    func showLoader(with title: String?, description: String?) -> PassthroughSubject<Bool, Never>
    
    func get(for screen: Screen) -> UIViewController
}

class RootCordinatorImp: NSObject, Cordinator {
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
    
    func navigate(to screen: Screen, transition: TransitionStyle) {
        performNavigation(vc: get(for: screen), transition: transition)
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
        performNavigation(vc: vc, transition: transition)
    }
    
    func showLoader(with title: String?, description: String?) -> PassthroughSubject<Bool, Never> {
        let dismissModalSubject: PassthroughSubject<Bool, Never> = .init()
        let loaderView = UIHostingController(
            rootView: BottomSheetModalView(
                c: C.color,
                viewModel: BottomSheetModalView.ViewModel(dismissModalSubject: dismissModalSubject, navigationController: navigationController)
            ) {
            LoaderView(c: C.color, f: C.font, title: "Loading", description: "Sometimes we will see BS stuff out of the blue to make things wonderful")
        })
        loaderView.view.backgroundColor = .clear
        loaderView.modalPresentationStyle = .overCurrentContext
        navigationController?.present(loaderView, animated: false)
        return dismissModalSubject
    }
    
    private func performNavigation(vc: UIViewController, transition: TransitionStyle) {
        switch transition {
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        case .fadeIn:
            navigationController?.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .present:
            navigationController?.present(vc, animated: true)
        }
        
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
