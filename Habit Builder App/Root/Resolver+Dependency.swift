//
//  Resolver+Dependency.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import Factory
import UIKit
import ReSwift
import Combine

// MARK: - Cordinators
extension Container {
    var navigationController: Factory<UINavigationController> {
        self { UINavigationController(rootViewController: Container.shared.rootCordinator().get(for: .landing)) }
            .singleton
    }
    
    var rootCordinator: Factory<Cordinator> {
        self { RootCordinatorImp() }
            .singleton
    }
    
    var navHandler: Factory<NavHandler> {
        self { NavHandlerImp() }
            .singleton
    }
}

// MARK: - ViewModels
extension Container {
    var landingViewModel: Factory<LandingView.ViewModel> {
        self { LandingView.ViewModel() }
    }
    
    var signUpViewModel: Factory<SignUpView.ViewModel> {
        self { SignUpView.ViewModel() }
    }
    
    var signInViewModel: Factory<SignInView.ViewModel> {
        self { SignInView.ViewModel() }
    }
    
    var onboardingViewModel: Factory<OnboardingView.ViewModel> {
        self { OnboardingView.ViewModel() }
    }
    
    var homeViewModel: Factory<HomeView.ViewModel> {
        self { HomeView.ViewModel() }
    }
}

// MARK: - States
extension Container {
    var store: Factory<Store<AppState>> {
        self { appStore }
    }
    
    typealias UserStateType = Publishers.Map<PassthroughSubject<AppState, Never>, UserState>
    var userState: Factory<UserStateType> {
        self { appStore.statePublisher.map { $0.userState } }
    }
    
    typealias HabitStateType = Publishers.Map<PassthroughSubject<AppState, Never>, HabitState>
    var habitState: Factory<HabitStateType> {
        self { appStore.statePublisher.map { $0.habitState } }
    }
}

// MARK: - Helpers
extension Container {
    var commonValidators: Factory<CommonValidators> {
        self { CommonValidators() }
            .singleton
    }
    
    var modalHelper: Factory<ModalHelper> {
        self { ModalHelperImp() }
    }
}

// MARK: - Network Helper
extension Container {
    var accountNetworkFirebaseHelper: Factory<AccountNetworkHelper> {
        self { AccountNetworkHelperFirebaseImp() }
            .singleton
    }
}

// MARK: - Core Data Helper
extension Container {
    var userCoreDataHelper: Factory<UserHelper> {
        self { UserCoreDataHelper() }
    }
    
    var habitCoreDataHelper: Factory<HabitHelper> {
        self { HabitCoreDataHelper() }
    }
}

// MARK: -  Other dependencies
extension Container {
    var coreDatabase: Factory<CoreDatabase> {
        self { CoreDatabaseImp() }
            .singleton
    }
}
