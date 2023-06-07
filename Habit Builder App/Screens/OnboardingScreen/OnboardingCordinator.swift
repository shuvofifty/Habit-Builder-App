//
//  OnboardingCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/24/23.
//

import Foundation
import Factory

protocol OnboardingCordinator: Cordinator {
    
}

class OnboardingCordinatorImp: OnboardingCordinator {
    @Injected(\.rootCordinator) var rootCordinator: Cordinator
    var router: Router?
    
    func navigate(to screen: Screen) {
        
    }
    
    
}
