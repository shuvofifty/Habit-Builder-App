//
//  EntityDebugger.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/3/23.
//

import Foundation
import CoreData
import Factory

class EntityDebugger {
    @Injected(\.coreDatabase) private var coreData: CoreDatabase
    
    func printAllData(for entity: NSManagedObject.Type) {
        let context = coreData.context
        let results = try! context.fetch(entity.fetchRequest()) as? [NSManagedObject]
        print("")
        print(">>>>>>>>>>=====Entity Stated=====<<<<<<<<<<<<<<<")
        print("")
        for result in results ?? [] {
            print("==========================")
            print(result.description)
        }
        print("")
        print(">>>>>>>>>>=====Entity Ended=====<<<<<<<<<<<<<<<")
        print("")
    }
    
    func removeAllData(for entity: NSManagedObject.Type) {
        let context = coreData.context
        try! context.execute(NSBatchDeleteRequest(fetchRequest: entity.fetchRequest()))
        print("")
        print(">>>>>>>>>>=====All Data got removed=====<<<<<<<<<<<<<<<")
        print("")
        try! context.save()
    }
}
