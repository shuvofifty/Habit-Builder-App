//
//  Extension+UIView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    func hook(to parent: UIView, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: parent.topAnchor, constant: top).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -bottom).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: parent.leftAnchor, constant: left).isActive = true
        }
    }
    
    func hook(to parent: UIView, with margin: CGFloat) {
        hook(to: parent, top: margin, right: margin, bottom: margin, left: margin)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
