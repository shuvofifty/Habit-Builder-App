//
//  HabitLogCoreDataHelper.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/3/23.
//

import Foundation
import Factory
import CoreData

protocol HabitLogHelper {
    
}

class HabitLogCoreDataHelper: HabitLogHelper {
    @Injected(\.coreDatabase) private var coreData: CoreDatabase
    
    func createHabitLog(for habitId: UUID, feelNote: String, complicationScore: Int) async throws {
        let context = coreData.context
        
        try context.performAndWait {
            guard getHabitWithLogForCurrentDate(context, id: habitId) == nil else {
                throw HabitLogError.habitAlreadyLoggedForToday
            }
            guard let habit = getHabitWithContext(context, id: habitId) else {
                throw HabitLogError.habitNotFound
            }
            let logEntity = HabitLogsEntity()
            logEntity.id = UUID()
            logEntity.feelingNotes = feelNote
            logEntity.complicationScore = complicationScore
            logEntity.dateCompleted = Date()
            
            habit.addToHabitLogs(logEntity)
            try context.save()
        }
    }
    
    private func getHabitWithContext(_ context: NSManagedObjectContext, id: UUID) -> HabitEntity? {
        let fetchRequest = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let existingHabits = try context.fetch(fetchRequest)
            return existingHabits.count > 0 ? existingHabits.first as? HabitEntity : nil
        } catch {
            print("Error Happened for fetching Habit: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getHabitWithLogForCurrentDate(_ context: NSManagedObjectContext, id: UUID) -> HabitEntity? {
        let fetchRequest = HabitEntity.fetchRequest()
        
        let currentDate = Calendar.current.startOfDay(for: Date())
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        let predicate = NSPredicate(format: "(id == %@) AND (ANY logs.dateCompleted >= %@) AND (ANY logs.dateCompleted < %@)", argumentArray: [currentDate, nextDate])
        
        fetchRequest.predicate = predicate
        
        do {
            let existingHabits = try context.fetch(fetchRequest)
            return existingHabits.count > 0 ? existingHabits.first as? HabitEntity : nil
        } catch {
            print("Error Happened for fetching Habit: \(error.localizedDescription)")
            return nil
        }
    }
    
    enum HabitLogError: LocalizedError {
        case habitNotFound
        case habitAlreadyLoggedForToday
        
        var errorDescription: String? {
            switch self {
            case .habitNotFound:
                return "We cannot find the habit"
            case .habitAlreadyLoggedForToday:
                return "Looks like this habit has been already logged for today"
            }
        }
    }
}
