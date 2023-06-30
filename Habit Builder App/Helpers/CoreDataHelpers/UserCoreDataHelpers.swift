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
    func createUser(with email: String, firebaseID: String) async throws -> UserEntity
    func updateUser(with email: String, name: String) async throws
    func printUserEntity()
    func removeAllUser()
}

class UserCoreDataHelper: UserHelper {
    @Injected(\.coreDatabase) private var coreData: CoreDatabase
    
    func createUser(with email: String, firebaseID: String) async throws -> UserEntity {
        let context = coreData.context
        var createdUserEntity: UserEntity?
        
        try context.performAndWait {
            guard getUserWithContext(context, email: email) == nil else {
                throw UserError.userAlreadyExist
            }
            
            let user = UserEntity(context: context)
            user.id = UUID()
            user.email = email
            user.dateCreated = Date()
            user.firebaseID = firebaseID
            
            try context.save()
            createdUserEntity = user
        }
        
        if let createdUserEntity = createdUserEntity {
            return createdUserEntity
        } else {
            throw UserError.unknown
        }
    }
    
    func updateUser(with email: String, name: String) async throws {
        let context = coreData.context
        
        try context.performAndWait {
            guard let user = getUserWithContext(context, email: email) else {
                throw UserError.userNotExist
            }
            
            user.name = name
            
            try context.save()
        }
    }
    
    func printUserEntity() {
        let context = coreData.context
        let allUser = try! context.fetch(UserEntity.fetchRequest()) as? [UserEntity]
        for user in allUser ?? [] {
            print(user.description)
        }
    }
    
    func removeAllUser() {
        let context = coreData.context
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserEntity.fetchRequest())
        try! context.execute(deleteRequest)
        try! context.save()
    }
    
    private func getUserWithContext(_ context: NSManagedObjectContext, email: String) -> UserEntity? {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email ==[c] %@", email)
        
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
    enum UserError: LocalizedError {
        case userAlreadyExist,
             userNotExist,
             unknown
        
        var errorDescription: String? {
            switch self {
            case .userAlreadyExist:
                return "User already exist"
            case .userNotExist:
                return "User does not exist"
            case .unknown:
                return "Some unknown error happened"
            }
        }
    }
}
