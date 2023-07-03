//
//  HomeViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/28/23.
//

import Foundation
import Factory
import ReSwift
import Combine

extension HomeView {
    class ViewModel: ObservableObject {
        @Injected(\.rootCordinator) var cordinator: Cordinator
        @Injected(\.userState) private var userState: Container.UserStateType
        @Injected(\.habitState) private var habitState: Container.HabitStateType
        @Injected(\.store) var store: Store<AppState>
        
        @Published var userName: String = ""
        @Published var habits: [HabitInfo] = []
        
        private var cancellable = Set<AnyCancellable>()
        
        init() {
            userState
                .compactMap { $0.userInfo?.name }
                .assign(to: \.userName, on: self)
                .store(in: &cancellable)
            
            habitState
                .map { $0.habits }
                .assign(to: \.habits, on: self)
                .store(in: &cancellable)
        }
    }
}
