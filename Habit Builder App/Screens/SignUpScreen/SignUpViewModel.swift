//
//  SignUpViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import Factory

extension SignUpView {
    enum Error {
        case none, emailFormat, password
    }
    
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
        @Injected(\.commonValidators) var validator: CommonValidators
        @Injected(\.accountNetworkHelper) var accountHelper: AccountNetworkHelper
        @Injected(\.modalHelper) var modalHelper: ModalHelper
        
        @Published var error: [Error: String] = [:]
        
        @MainActor
        func continueButtonTapped(email: String, password: String) {
            guard isValid(email: email), isValid(password: password) else {
                return
            }
            modalHelper.show(.loader(title: "Creating Account", description: "Easily track your progress and all other habits with the account"))
            Task {
                do {
                    let user = try await accountHelper.createAccount(for: email, password: password)
                    modalHelper.dismiss()
                } catch {
                    modalHelper.show(.error(title: "Failed to create account", description: "Looks like something went wrong while trying to create an account. Error \(error.localizedDescription)"))
                }
            }
        }
        
        func isValid(email: String) -> Bool {
            guard !email.isEmpty else {
                error[.emailFormat] = "Valid email address is required"
                return false
            }
            guard validator.isValidEmail(email) else {
                error[.emailFormat] = "Looks like the email is not valid"
                return false
            }
            error.removeValue(forKey: .emailFormat)
            return true
        }
        
        func isValid(password: String) -> Bool {
            guard !password.isEmpty else {
                error[.password] = "Need a strong password to protect your account"
                return false
            }
            error.removeValue(forKey: .password)
            return true
        }
    }
}
