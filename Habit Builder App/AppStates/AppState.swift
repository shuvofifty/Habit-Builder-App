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
    var state = state ?? AppState(userState: UserState(isLoggedIn: false))
    state.userState = userReducer(action: action, state: state.userState)
    return state
}

let appStore = ObservableStore(
    reducer: appReducer,
    state: nil,
    middleware: [
        userLoginMiddleWare(resource: UserLoginResource())
    ]
)
