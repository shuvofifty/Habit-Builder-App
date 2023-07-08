//
//  HabitLogViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/8/23.
//

import Foundation
import Combine
import Factory

extension HabitLogView {
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
        
    }
}
