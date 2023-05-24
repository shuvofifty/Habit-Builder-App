//
//  SignUpCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import Factory
import UIKit

protocol SignUpCordinator: Cordinator {
    
}

class SignUpCordinatorImp: SignUpCordinator {
    var rootCordinator: RootCordinator
    
    init(rootCordinator: RootCordinator) {
        self.rootCordinator = rootCordinator
    }
    
    func start() {
        rootCordinator.router?.push(
            SignUpViewController(viewModel: Container.shared.signUpViewModel()),
            animated: true
        )
    }
}
