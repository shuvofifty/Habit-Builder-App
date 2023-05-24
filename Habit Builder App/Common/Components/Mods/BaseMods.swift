//
//  Wrappers.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/14/23.
//

import Foundation
import SwiftUI

public enum BaseMods {
    case fullWidth(alignment: Alignment = .leading),
         fullHeight(alignment: Alignment = .leading)
}

public extension View {
    func add(mod: BaseMods) -> some View {
        switch mod {
        case .fullWidth(alignment: let alignment):
            return frame(maxWidth: .infinity, alignment: alignment)
        case .fullHeight(alignment: let alignment):
            return frame(maxHeight: .infinity, alignment: alignment)
        }
    }
}
