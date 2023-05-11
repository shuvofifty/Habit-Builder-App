//
//  SignUpViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation

extension SignUpView {
    class ViewModel: ObservableObject {
        let cordinator: SignUpCordinator
        
        init(cordinator: SignUpCordinator) {
            self.cordinator = cordinator
        }
    }
}
