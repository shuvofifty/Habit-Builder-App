//
//  HomeViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/28/23.
//

import Foundation
import Factory

extension HomeView {
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
    }
}
