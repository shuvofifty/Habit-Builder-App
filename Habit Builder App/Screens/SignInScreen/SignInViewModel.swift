//
//  SignInViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/20/23.
//

import Foundation
import Combine
import Factory

extension SignInView {
    enum Error {
        case none, emailFormat, password
    }
    
    class ViewModel: ObservableObject {
        
        @Injected(\.commonValidators) private var validator: CommonValidators
        @Injected(\.modalHelper) private var modalHelper: ModalHelper
        var modalNew = ModalHelperRefactorImp()
        
        @Published var error: [Error: String] = [:]
        
        private var store = appStore
        private var cancellable: Set<AnyCancellable> = []
        
        func setupStoreBindings() {
            let userState = store
                .statePublisher
                .map { $0.userState }
            
            userState
                .map { $0.shouldShowLoader }
                .sink {[weak self] showLoader in
                    if showLoader {
                        self?.modalHelper.show(.loader(title: "Checikng credentials", description: "With the help of account you will be able to track all your progress"))
                    } else {
                        self?.modalHelper.dismiss()
                    }
                }
                .store(in: &cancellable)
            
            userState
                .compactMap { $0.errorMessage }
                .sink {[weak self] error in
                    self?.modalHelper.show(.error(title: "Ahh something is not right", description: error))
                }
                .store(in: &cancellable)
        }
        
        func continueButtonTapped(email: String, password: String) {
            store.dispatch(UserAction.login(email: email, password: password))
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
        
        func testModal() {
            modalNew.show(.loader(title: nil, description: nil), with: "paparaji")
        }
    }
}
