//
//  OnboardingViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/24/23.
//

import Foundation
import Factory

extension OnboardingView {
    class ViewModel: ObservableObject {
        @Injected(\.onboardingCordinator) var cordinator: OnboardingCordinator
        
        
    }
}
