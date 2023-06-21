//
//  UserState.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/20/23.
//

import Foundation
import Factory
import ReSwift

struct UserState {
    var isLoggedIn: Bool = false
    var shouldShowLoader: Bool = false
    var errorMessage: String? = nil
    var userInfo: UserInfo = UserInfo(email: "")
}

enum UserAction: Action {
    case login(email: String, password: String)
    case loginSuccess(_ userInfo: UserInfo)
    case loginFailed(_ error: String)
    case loader(_ shouldShow: Bool)
}

// Reducer is responsible for changing data not middleware
func userReducer(action: Action, state: UserState?) -> UserState {
    var state = state ?? UserState()
    
    switch action {
    case let userAction as UserAction:
        switch userAction {
        case .loginSuccess(let userInfo):
            state.userInfo = userInfo
            state.errorMessage = nil
            state.isLoggedIn = false
            
        case .loginFailed(let error):
            state.isLoggedIn = false
            state.errorMessage = error
            
        case .loader(let shouldShow):
            state.shouldShowLoader = shouldShow
            
        default:
            break
        }
    default:
        break
    }
    return state
}

struct UserLoginResource {
    @Injected(\.accountNetworkFirebaseHelper) var accountHelper: AccountNetworkHelper
}

// Do all async stuff here
func userLoginMiddleWare(resource: UserLoginResource) -> Middleware<AppState> {
    { dispatch, getState in
        { next in
            { action in
                next(action)
                guard let userAction = action as? UserAction, case .login(let email, let password) = userAction else { return }
                
                dispatch(UserAction.loader(true))
                
                Task {
                    do {
                        let user = try await resource.accountHelper.signInUser(for: email, password: password)
                        dispatch(UserAction.loader(false))
                        dispatch(UserAction.loginSuccess(user))
                    } catch {
                        dispatch(UserAction.loginFailed(error.localizedDescription))
                    }
                }
            }
        }
    }
}
