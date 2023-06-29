//
//  CoreDatabase.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/28/23.
//

import Foundation
import CoreData

protocol CoreDatabase {
    var context: NSManagedObjectContext { get }
    
    func saveContext() async throws
}

class CoreDatabaseImp: CoreDatabase {
    private let containerName = "HabitBuilderCDModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() async throws {
        try await context.perform {[unowned self] in
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    throw error
                }
            }
        }
    }
}
