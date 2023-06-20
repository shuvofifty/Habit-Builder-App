//
//  AccountHelper.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth

protocol AccountNetworkHelper {
    func createAccount(for email: String, password: String) async throws -> User
}

class AccountNetworkHelperFirebaseImp: AccountNetworkHelper {
    func createAccount(for email: String, password: String) async throws -> User  {
        return try await withCheckedThrowingContinuation({ continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let user = authResult?.user {
                    continuation.resume(returning: user)
                    return
                }
                continuation.resume(throwing: NSError(domain: "", code: -1))
            }
        })
    }
}
