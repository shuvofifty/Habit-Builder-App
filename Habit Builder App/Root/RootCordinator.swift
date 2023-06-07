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
    func navigate(to screen: Screen)
    func navigate(to screen: Screen, using currentRouterID: RouterID, to destinationRouterID: RouterID)
    func get(for id: RouterID, ifNotPresentGetwith rootScreen: Screen) -> Router
}

class RootCordinatorImp: Cordinator {
    var routerMap: [RouterID: Router] = [:]
    
    private func get(for screen: Screen) -> UIViewController {
        switch screen {
        case .landing:
            return LandingViewController(viewModel: Container.shared.landingViewModel())
        case .signUp:
            return SignUpViewController(viewModel: Container.shared.signUpViewModel())
        case .onboarding:
            return OnboardingViewController(viewModel: Container.shared.onboardingViewModel())
        }
    }
    
    private func get(for id: RouterID) -> Router {
        guard let customRoute = routerMap[id] else {
            routerMap[id] = RouterImp()
            return routerMap[id]!
        }
        return customRoute
    }
    
    func get(for id: RouterID, ifNotPresentGetwith rootScreen: Screen) -> Router {
        var router = get(for: id)
        if router.navigationController == nil {
            router.navigationController = UINavigationController(rootViewController: get(for: rootScreen))
        }
        return router
    }
    
    func navigate(to screen: Screen) {
        navigate(to: screen, using: .regular, to: .regular)
    }
    
    func navigate(to screen: Screen, using currentRouterID: RouterID, to destinationRouterID: RouterID) {
        let currentRouter = get(for: currentRouterID, ifNotPresentGetwith: screen)
        
        guard currentRouterID != destinationRouterID else {
            currentRouter.push(get(for: screen), animated: true)
            return
        }
        
        guard let destinatonRouter = routerMap[destinationRouterID] else {
            fatalError("Destination router \(destinationRouterID) is not present in the router map")
        }
        
        destinatonRouter.push(currentRouter, animated: true)
    }
}

enum RouterID: String {
    case onBoardingRouter, regular
}
