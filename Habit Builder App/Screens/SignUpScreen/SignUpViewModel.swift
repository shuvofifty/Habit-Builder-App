//
//  SignUpViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import Factory
import ReSwift
import Combine

extension SignUpView {
    enum Error {
        case none, emailFormat, password
    }
    
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
        @Injected(\.commonValidators) var validator: CommonValidators
        @Injected(\.modalHelper) var modalHelper: ModalHelper
        
        @Injected(\.userState) private var userState: Container.UserStateType
        @Injected(\.store) private var store: Store<AppState>
        private var cancellable = Set<AnyCancellable>()
        
        @Published var error: [Error: String] = [:]
        
        init() {
            userState
                .map { $0.shouldShowLoader }
                .sink {[weak self] showLoader in
                    if showLoader {
                        self?.modalHelper.show(.loader(title: "Creating Account", description: "Easily track your progress and all other habits with the account"), with: CommonModalID.LOADING.rawValue)
                    } else {
                        self?.modalHelper.dismiss(id: CommonModalID.LOADING.rawValue)
                    }
                }
                .store(in: &cancellable)
            
            userState
                .compactMap { $0.errorMessage }
                .sink {[weak self] error in
                    self?.modalHelper.show(.error(title: "Failed to create account", description: error), with: CommonModalID.ERROR.rawValue)
                }
                .store(in: &cancellable)
            
            userState
                .filter { $0.isLoggedIn }
                .compactMap { $0.userInfo }
                .sink {[weak self] _ in
                    self?.cordinator.navigate(to: .onboarding, transition: .fadeIn)
                }
                .store(in: &cancellable)
        }
        
        func continueButtonTapped(email: String, password: String) {
            guard isValid(email: email), isValid(password: password) else {
                return
            }
            store.dispatch(UserAction.createAccount(email: email, password: password))
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
