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
        @Injected(\.userState) var userState: Container.UserStateType
        
        @Published var userName: String = ""
        
        private var cancellable = Set<AnyCancellable>()
        
        init() {
            userState
                .compactMap { $0.userInfo?.name }
                .assign(to: \.userName, on: self)
                .store(in: &cancellable)
        }
    }
}
