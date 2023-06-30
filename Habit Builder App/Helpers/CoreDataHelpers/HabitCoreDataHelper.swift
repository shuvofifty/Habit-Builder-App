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
            
            let mutableHabits = user.habits as? NSMutableOrderedSet
            mutableHabits?.add(habitEntity)
            
            user.habits = mutableHabits
            
            try context.save()
            createdHabitEntity = habitEntity
        }
        
        if let habit = createdHabitEntity {
            return habit
        } else {
            throw HabitError.habitCreationFailed
        }
    }
    
    private func getUserWithContext(_ context: NSManagedObjectContext, id: UUID) -> UserEntity? {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate {(evaluatedObject, bindings) -> Bool in
            let userEntity = evaluatedObject as! UserEntity
            return userEntity.id == id
        }
        
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
        case habitCreationFailed
        
        var errorDescription: String? {
            switch self {
            case .userNotFound:
                return "Could not find user"
            case .habitCreationFailed:
                return "Unable to create habit entity"
            }
        }
    }
}
