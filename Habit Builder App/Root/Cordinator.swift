//
//  Cordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/3/23.
//

import Foundation

/// All Cordinator must follow this protocol
protocol Cordinator: AnyObject {
    var rootCordinator: RootCordinator { get }
    
    func start()
    /// Get a starting a vc that will wrap with router
    func getWithRouter() -> Router?
}

extension Cordinator {
    func getWithRouter() -> Router? { nil }
}

/*
 This is the base cordinator that will be called from AppDelegate and all other cordinator will have weak reference to it. It will be parent of all cordinators
 */
protocol RootCordinator: AnyObject, CordinatorSources {
    var router: Router? { get }
}

/*
 All Cordinator in the app goes here
 */
protocol CordinatorSources {
    var landingCordinator: LandingCordinator { get }
    var signupCordinator: SignUpCordinator { get }
}
