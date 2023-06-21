//
//  AccountHelper.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth

struct UserInfo {
    var email: String
    var name: String?
}

protocol AccountNetworkHelper {
    func createAccount(for email: String, password: String) async throws -> UserInfo
    func signInUser(for email: String, password: String) async throws -> UserInfo
}

class AccountNetworkHelperFirebaseImp: AccountNetworkHelper {
    func createAccount(for email: String, password: String) async throws -> UserInfo  {
        return try await withCheckedThrowingContinuation({ continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let user = authResult?.user {
                    continuation.resume(returning: UserInfo(email: user.email ?? ""))
                    return
                }
                continuation.resume(throwing: NSError(domain: "", code: -1))
            }
        })
    }
    
    func signInUser(for email: String, password: String) async throws -> UserInfo {
        try await withCheckedThrowingContinuation({ continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let user = authResult?.user {
                    continuation.resume(returning: UserInfo(email: user.email ?? ""))
                    return
                }
                continuation.resume(throwing: NSError(domain: "", code: -1))
            }
        })
    }
}
