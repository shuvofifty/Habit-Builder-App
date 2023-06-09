//
//  CommonValidators.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/9/23.
//

import Foundation

class CommonValidators {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
