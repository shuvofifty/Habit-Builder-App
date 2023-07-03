//
//  Extension+UIView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import CoreData

extension UIView {
    func hook(to parent: UIView, safeArea: Bool, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: safeArea ? parent.safeAreaLayoutGuide.topAnchor : parent.topAnchor, constant: top).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: safeArea ? parent.safeAreaLayoutGuide.rightAnchor :  parent.rightAnchor, constant: -right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: safeArea ? parent.safeAreaLayoutGuide.bottomAnchor : parent.bottomAnchor, constant: -bottom).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: safeArea ? parent.safeAreaLayoutGuide.leftAnchor : parent.leftAnchor, constant: left).isActive = true
        }
    }
    
    func hook(to parent: UIView, safeArea: Bool = false, with margin: CGFloat) {
        hook(to: parent, safeArea: safeArea, top: margin, right: margin, bottom: margin, left: margin)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public extension ObservableObject {
    func cancelSubscription(_ cancellable: inout Set<AnyCancellable>) {
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
    }
}

public extension NSManagedObject {
    override var description: String {
        let keys = Array(entity.attributesByName.keys)
        let dict = dictionaryWithValues(forKeys: keys)
        return "\(entity.name!) \(dict.description)"
    }
}
