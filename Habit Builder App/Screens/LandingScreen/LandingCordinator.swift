//
//  LandingCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/24/23.
//

import Foundation
import Factory

protocol LandingCordinator: Cordinator {
    
}

class LandingCordinatorImp: LandingCordinator {
    var router: Router?
    
    @Injected(\.rootCordinator) var rootCordinator: Cordinator
    
    func navigate(to screen: Screen) {
        rootCordinator.navigate(to: screen)
    }
}
