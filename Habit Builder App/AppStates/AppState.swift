//
//  AppState.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/20/23.
//

import Foundation
import ReSwift
import Combine
import Factory

struct AppState {
    var userState: UserState
    var habitState: HabitState
}

class ObservableStore: Store<AppState> {
    let statePublisher = PassthroughSubject<AppState, Never>()
    
    override func _defaultDispatch(action: Action) {
        super._defaultDispatch(action: action)
        statePublisher.send(self.state)
    }
}

// Eacher state will have one reducer only
private func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState(
        userState: UserState(isLoggedIn: false),
        habitState: HabitState()
    )
    state.userState = userReducer(action: action, state: state.userState)
    state.habitState = habitReducer(action: action, state: state.habitState)
    return state
}

let appStore = ObservableStore(
    reducer: appReducer,
    state: nil,
    middleware: [
        userLoginMiddleWare(resource: UserStateResource()),
        createUserAccountMiddleWare(resource: UserStateResource()),
        updateUserInfo(resource: UserStateResource())
        
        
    ]
)

func MainThread(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}
