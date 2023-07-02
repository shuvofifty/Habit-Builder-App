//
//  SignInViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/20/23.
//

import Foundation
import Combine
import Factory
import ReSwift

extension SignInView {
    enum Error {
        case none, emailFormat, password
    }
    
    class ViewModel: ObservableObject {
        enum Modal_ID: String {
            case LOADER, ERROR
        }
        
        @Injected(\.rootCordinator) private var cordinator: Cordinator
        @Injected(\.commonValidators) private var validator: CommonValidators
        @Injected(\.modalHelper) private var modalHelper: ModalHelper
        
        @Published var error: [Error: String] = [:]
        
        @Injected(\.userState) private var userState: Container.UserStateType
        @Injected(\.store) private var store: Store<AppState>
        
        private var cancellable: Set<AnyCancellable> = []
        
        func setupStoreBindings() {
            userState
                .map { $0.shouldShowLoader }
                .removeDuplicates()
                .sink {[weak self] showLoader in
                    if showLoader {
                        self?.modalHelper.show(.loader(title: "Checikng credentials", description: "With the help of account you will be able to track all your progress"), with: Modal_ID.LOADER.rawValue)
                    } else {
                        self?.modalHelper.dismiss(id: Modal_ID.LOADER.rawValue)
                    }
                }
                .store(in: &cancellable)
            
            userState
                .compactMap { $0.errorMessage }
                .sink {[weak self] error in
                    self?.modalHelper.show(.error(title: "Ahh something is not right", description: error), with: Modal_ID.ERROR.rawValue)
                }
                .store(in: &cancellable)
            
            userState
                .map { $0.isLoggedIn }
                .removeDuplicates()
                .filter { $0 }
                .sink {[unowned self] _ in
                    self.store.dispatch(HabitAction.getAllHabits)
                    self.cordinator.navigate(to: .home, transition: .push)
                    self.cancelSubscription(&cancellable)
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
    }
}
