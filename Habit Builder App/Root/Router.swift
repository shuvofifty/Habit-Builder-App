//
//  Router.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/2/23.
//

import Foundation
import UIKit

protocol NavHandler {
    func getNavController(for screen: Screen) -> UINavigationController
    func initiateNavFor(screen: Screen, rootScreen: UIViewController)
    func popViewController(for screen: Screen, animated: Bool)
}

class NavHandlerImp: NavHandler {
    
    private var baseNavController: UINavigationController? = nil
    private var homeNavController: UINavigationController? = nil
    private var graphNavController: UINavigationController? = nil
    private var accountNavController: UINavigationController? = nil
    
    func getNavController(for screen: Screen) -> UINavigationController {
        switch screen {
        case .landing, .signUp, .signIn, .onboarding:
            guard let baseNavController = baseNavController else {
                fatalError("Root Screen for BaseNavController is not present")
            }
            return baseNavController
        case .home:
            guard let homeNavController = homeNavController else {
                fatalError("Root Screen for HomeNavController is not present")
            }
            return homeNavController
        }
    }
    
    func initiateNavFor(screen: Screen, rootScreen: UIViewController) {
        switch screen {
        case .landing, .signUp, .signIn, .onboarding:
            guard baseNavController == nil else {
                print("Base Nav Controller already exist")
                return
            }
            baseNavController = UINavigationController(rootViewController: rootScreen)
        case .home:
            guard homeNavController == nil else {
                print("Home Nav Controller already exist")
                return
            }
            homeNavController = UINavigationController(rootViewController: rootScreen)
        }
    }
    
    func popViewController(for screen: Screen, animated: Bool) {
        getNavController(for: screen).popViewController(animated: animated)
    }
}
