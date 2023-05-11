//
//  SignUpCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
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
            SignUpViewController(viewModel: SignUpView.ViewModel(cordinator: self)),
            animated: true
        )
    }
}
