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
        
        func showModal() {
            let subject = cordinator.showLoader(with: nil, description: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                subject.send(false)
            }
        }
    }
}
