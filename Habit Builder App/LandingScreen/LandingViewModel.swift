//
//  LandingViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation

extension LandingView {
    class ViewModel: ObservableObject {
        var cordinator: LandingCordinator
        
        init(cordinator: LandingCordinator) {
            self.cordinator = cordinator
        }
    }
}
