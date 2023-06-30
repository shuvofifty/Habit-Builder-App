//
//  Entities.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/29/23.
//

import Foundation
import CoreData

/// This help ensures all entries are unique
protocol CoreDataManageableObject {
    var id: UUID? { get set }
}

@objc(UserEntity)
class UserEntity: NSManagedObject, CoreDataManageableObject {
    @NSManaged var id: UUID?
    @NSManaged var firebaseID: String?
    @NSManaged var email: String?
    @NSManaged var name: String?
    @NSManaged var dateCreated: Date?
    @NSManaged var habits: NSOrderedSet?
}

extension UserEntity {
    @objc(addHabitsObject:)
    @NSManaged public func addToHabits(_ value: HabitEntity)

    @objc(removeHabitsObject:)
    @NSManaged public func removeFromHabits(_ value: HabitEntity)

    @objc(addHabits:)
    @NSManaged public func addToHabits(_ values: NSOrderedSet)

    @objc(removeHabits:)
    @NSManaged public func removeFromHabits(_ values: NSOrderedSet)
}

@objc(HabitEntity)
class HabitEntity: NSManagedObject, CoreDataManageableObject {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var reason: String?
    @NSManaged var dateCreated: Date?
}
