//
//  HabitCoreDataHelper.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/30/23.
//

import Foundation
import CoreData
import Factory

protocol HabitHelper {
    func createHabit(for userId: UUID, name: String, reason: String) async throws -> HabitEntity
    func getAllHabits(for userId: UUID) async throws -> [HabitInfo]
}

class HabitCoreDataHelper: HabitHelper {
    @Injected(\.coreDatabase) private var coreData: CoreDatabase
    
    func createHabit(for userId: UUID, name: String, reason: String) async throws -> HabitEntity {
        let context = coreData.context
        var createdHabitEntity: HabitEntity?
        
        try context.performAndWait {
            guard let user = getUserWithContext(context, id: userId) else {
                throw HabitError.userNotFound
            }
            
            let habitEntity = HabitEntity(context: context)
            habitEntity.id = UUID()
            habitEntity.name = name
            habitEntity.reason = reason
            habitEntity.dateCreated = Date()
            
            user.addToHabits(habitEntity)
            
            try context.save()
            createdHabitEntity = habitEntity
        }
        
        if let habit = createdHabitEntity {
            return habit
        } else {
            throw HabitError.habitCreationFailed
        }
    }
    
    func getAllHabits(for userId: UUID) async throws -> [HabitInfo] {
        let context = coreData.context
        var habits: [HabitInfo]?
        
        try context.performAndWait {
            guard let user = getUserWithContext(context, id: userId) else {
                throw HabitError.userNotFound
            }
            
            habits = []
            /**
             This is done to fight faulting. Reference to iOS doc created by you
             Basicaly, core data get only relationsal information when needed to save memory. The process is called faulting
            **/
            let habitEntities = user.habits?.compactMap { $0 as? HabitEntity }
            
            
            if let habitEntities = habitEntities {
                for habit in habitEntities {
                    habits?.append(
                        HabitInfo(
                            name: habit.name ?? "",
                            reason: habit.reason ?? "",
                            dateCreated: habit.dateCreated ?? Date()
                        )
                    )
                }
            } else {
                throw HabitError.failedToGetHabit
            }
            
        }
        
        if let habits = habits {
            return habits
        } else {
            throw HabitError.failedToGetHabit
        }
    }
    
    private func getUserWithContext(_ context: NSManagedObjectContext, id: UUID) -> UserEntity? {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            return existingUsers.count > 0 ? existingUsers.first as? UserEntity : nil
        } catch {
            print("Error Happened for fetching user: \(error.localizedDescription)")
            return nil
        }
    }
}

extension HabitCoreDataHelper {
    enum HabitError: LocalizedError {
        case userNotFound
        case failedToGetHabit
        case habitCreationFailed
        
        var errorDescription: String? {
            switch self {
            case .userNotFound:
                return "Could not find user"
            case .habitCreationFailed:
                return "Unable to create habit entity"
            case .failedToGetHabit:
                return "Failed get habit list for the user"
            }
        }
    }
}
