//
//  LandingViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import Factory

extension LandingView {
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
        
        // TODO: - Remove this
        @Injected(\.entityDebugger) var debugger: EntityDebugger
        
        init() {
//            debugger.removeAllData(for: HabitEntity.self)
//            debugger.removeAllData(for: UserEntity.self)
            
            debugger.printAllData(for: UserEntity.self)
            debugger.printAllData(for: HabitEntity.self)
            debugger.printAllData(for: HabitLogs.self)
        }
        
    }
}
