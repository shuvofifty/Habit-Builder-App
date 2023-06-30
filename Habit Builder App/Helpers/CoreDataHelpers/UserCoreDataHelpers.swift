//
//  UserCoreDataHelpers.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/29/23.
//

import Foundation
import Factory
import CoreData

protocol UserHelper {
    func createUser(with email: String) async throws
}

class UserCoreDataHelper: UserHelper {
    @Injected(\.coreDatabase) private var coreData: CoreDatabase
    
    func createUser(with email: String) async throws {
        let context = coreData.context
        
        try context.performAndWait {
            guard getUserWithContext(context, email: email) == nil else {
                throw UserError.userAlreadyExist
            }
            
            let user = UserEntity(context: context)
            user.id = UUID()
            user.email = email
            user.dateCreated = Date()
            
            try context.save()
        }
    }
    
    private func getUserWithContext(_ context: NSManagedObjectContext, email: String) -> UserEntity? {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            return existingUsers.count > 0 ? existingUsers.first as? UserEntity : nil
        } catch {
            print("Error Happened for fetching user: \(error.localizedDescription)")
            return nil
        }
    }
}

extension UserCoreDataHelper {
    enum UserError: Error {
        case userAlreadyExist, unknown
    }
}
