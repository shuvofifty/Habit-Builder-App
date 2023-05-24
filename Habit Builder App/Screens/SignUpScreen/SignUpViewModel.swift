//
//  SignUpViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import Factory

extension SignUpView {
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
    }
}
