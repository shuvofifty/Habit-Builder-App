//
//  HabitsState.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/30/23.
//

import Foundation
import ReSwift
import Factory

struct HabitInfo: Identifiable {
    var id = UUID()
    var name: String = ""
    var reason: String = ""
    var dateCreated: Date = Date()
}

struct HabitState {
    var habits: [HabitInfo] = []
    
    var shouldShowLoader: Bool = false
    var errorMessage: String?
    
    var habitSaveSuccess: Bool = false
    
    var didFetchAllHabitIntiated: Bool = false
    var didFetchAllHabitSuccess: Bool = false
    var fetchAllHabitError: String? = nil
}

enum HabitAction: Action {
    case saveHabit(_ name: String, _ reason: String)
    case saveHabitFailed(_ errorMsg: String)
    case saveHabitSuccess(_ habitInfo: HabitInfo)
    
    case getAllHabits
    case updateHabitStoreSuccess(_ habits: [HabitInfo])
    case updateHabitStoreFailed(_ errorMsg: String)
    
    case loader(_ showLoader: Bool)
}

func habitReducer(action: Action, state: HabitState?) -> HabitState {
    var state = state ?? HabitState()
    
    switch action {
    case let habitAction as HabitAction:
        switch habitAction {
        case .saveHabit:
            state.errorMessage = nil
            state.habitSaveSuccess = false
            
        case .loader(let shouldShow):
            state.shouldShowLoader = shouldShow
            
        case .saveHabitFailed(let error):
            state.errorMessage = error
            state.habitSaveSuccess = false
            
        case .saveHabitSuccess(let habitInfo):
            state.errorMessage = nil
            state.habits.append(habitInfo)
            state.habitSaveSuccess = true
            
        case .updateHabitStoreSuccess(let habitInfos):
            state.habits = habitInfos
            state.didFetchAllHabitIntiated = false
            state.didFetchAllHabitSuccess = true
            state.fetchAllHabitError = nil
            
        case .getAllHabits:
            state.didFetchAllHabitIntiated = true
            state.didFetchAllHabitSuccess = false
            state.fetchAllHabitError = nil
            
        case .updateHabitStoreFailed(let msg):
            state.didFetchAllHabitIntiated = false
            state.didFetchAllHabitSuccess = false
            state.fetchAllHabitError = msg
        }
    default:
        break
    }
    return state
}

struct HabitStateResource {
    @Injected(\.habitCoreDataHelper) var habitHelper: HabitHelper
}

func createHabitMiddleWare(resource: HabitStateResource) -> Middleware<AppState> {
    { dispatch, getState in
        { next in
            { action in
                next(action)
                guard let habitAction = action as? HabitAction, case .saveHabit(let name, let reason) = habitAction, let uid = getState()?.userState.userInfo?.uid else { return }
                
                Task {
                    do {
                        let habitEntity = try await resource.habitHelper.createHabit(for: uid, name: name, reason: reason)
                        let habitInfo = HabitInfo(name: habitEntity.name!, reason: habitEntity.reason!, dateCreated: habitEntity.dateCreated!)
                        
                        MainThread {
                            dispatch(HabitAction.saveHabitSuccess(habitInfo))
                        }
                    } catch let error as LocalizedError {
                        MainThread {
                            dispatch(HabitAction.saveHabitFailed(error.errorDescription ?? ""))
                        }
                    }
                }
            }
        }
    }
}

func getHabitsMiddleWare(resource: HabitStateResource) -> Middleware<AppState> {
    { dispatch, getState in
        { next in
            { action in
                next(action)
                guard let habitAction = action as? HabitAction, case .getAllHabits = habitAction, let uid = getState()?.userState.userInfo?.uid else { return }
                
                Task {
                    do {
                        let habits = try await resource.habitHelper.getAllHabits(for: uid)
                        MainThread {
                            dispatch(HabitAction.updateHabitStoreSuccess(habits))
                        }
                    } catch let error as LocalizedError {
                        MainThread {
                            dispatch(HabitAction.updateHabitStoreFailed(error.errorDescription ?? ""))
                        }
                    }
                }
            }
        }
    }
}
