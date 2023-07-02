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
    var userInfo: UserInfo? = nil
    var updateSuccess: Bool = false
}

enum UserAction: Action {
    case login(email: String, password: String)
    case loginSuccess(_ userInfo: UserInfo)
    case loginFailed(_ error: String)
    
    case loader(_ shouldShow: Bool)
    
    case createAccount(email: String, password: String)
    case createAccountSuccess(_ userInfo: UserInfo)
    case createAccountFailed(_ error: String)
    
    case update(name: String)
    case updateSuccessUserInfo(_ userInfo: UserInfo?)
    case updateFailed(_ error: String)
}

// Reducer is responsible for changing data not middleware
func userReducer(action: Action, state: UserState?) -> UserState {
    var state = state ?? UserState()
    
    switch action {
    case let userAction as UserAction:
        switch userAction {
        case .login, .createAccount:
            state.errorMessage = nil
            state.isLoggedIn = false
            state.shouldShowLoader = false
            state.userInfo = nil
            
        case .loginSuccess(let userInfo), .createAccountSuccess(let userInfo):
            state.userInfo = userInfo
            state.errorMessage = nil
            state.isLoggedIn = true
            
        case .loginFailed(let error), .createAccountFailed(let error):
            state.isLoggedIn = false
            state.errorMessage = error
            state.userInfo = nil
            
        case .loader(let shouldShow):
            state.shouldShowLoader = shouldShow
            
        case .update:
            state.errorMessage = nil
            state.updateSuccess = false
            
        case .updateSuccessUserInfo(let userInfo):
            state.userInfo = userInfo
            state.errorMessage = nil
            state.updateSuccess = true
            
        case .updateFailed(let error):
            state.errorMessage = error
            state.updateSuccess = false
        }
    default:
        break
    }
    return state
}

struct UserStateResource {
    @Injected(\.accountNetworkFirebaseHelper) var accountHelper: AccountNetworkHelper
    @Injected(\.userCoreDataHelper) var userHelper: UserHelper
}

// Do all async stuff here
func userLoginMiddleWare(resource: UserStateResource) -> Middleware<AppState> {
    { dispatch, getState in
        { next in
            { action in
                next(action)
                guard let userAction = action as? UserAction, case .login(let email, let password) = userAction else { return }
                
                MainThread {
                    dispatch(UserAction.loader(true))
                }
                
                Task {
                    do {
                        var userInfofromFirebase = try await resource.accountHelper.signInUser(for: email, password: password)
                        let uuid = try await resource.userHelper.getUserID(with: userInfofromFirebase.email)
                        userInfofromFirebase.uid = uuid
                        
                        MainThread {
                            dispatch(UserAction.loader(false))
                            dispatch(UserAction.loginSuccess(userInfofromFirebase))
                        }
                    } catch {
                        MainThread {
                            dispatch(UserAction.loader(false))
                            dispatch(UserAction.loginFailed(error.localizedDescription))
                        }
                    }
                }
            }
        }
    }
}

func createUserAccountMiddleWare(resource: UserStateResource) -> Middleware<AppState> {
    { dispatch, getState in
        { next in
            { action in
                next(action)
                guard let userAction = action as? UserAction, case .createAccount(let email, let password) = userAction else { return }
                
                MainThread {
                    dispatch(UserAction.loader(true))
                }
                
                Task {
                    do {
                        var user = try await resource.accountHelper.createAccount(for: email, password: password)
                        let userEntity = try await resource.userHelper.createUser(with: email, firebaseID: user.firebaseID)
                        user.uid = userEntity.id
                        
                        MainThread {
                            dispatch(UserAction.loader(false))
                            dispatch(UserAction.createAccountSuccess(user))
                        }
                    } catch {
                        MainThread {
                            dispatch(UserAction.loader(false))
                            dispatch(UserAction.createAccountFailed(error.localizedDescription))
                        }
                    }
                }
            }
        }
    }
}

func updateUserInfo(resource: UserStateResource) -> Middleware<AppState> {
    { dispatch, getState in
        { next in
            { action in
                next(action)
                guard let userAction = action as? UserAction, case .update(let name) = userAction, let userInfo = getState()?.userState.userInfo else { return }
                
                Task {
                    do {
                        try await resource.userHelper.updateUser(with: userInfo.email, name: name)
                        var updatedUserInfo = userInfo
                        updatedUserInfo.name = name
                        MainThread {
                            dispatch(UserAction.updateSuccessUserInfo(updatedUserInfo))
                        }
                    } catch let error as LocalizedError {
                        MainThread {
                            dispatch(UserAction.updateFailed(error.errorDescription ?? ""))
                        }
                    }
                }
            }
        }
    }
}
