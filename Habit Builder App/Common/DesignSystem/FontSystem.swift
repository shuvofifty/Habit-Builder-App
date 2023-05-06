//
//  FontSystem.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

public enum FontType {
    case body, h1, h2, h3, secondaryElements, successMessage, smallText, xSmallText, custom(size: CGFloat, lineSpace: CGFloat)
}

public protocol FontSystem {
    func get(for type: FontType, customWeight: UIFont.Weight?) -> UIFont
    func get(for type: FontType, customWeight: UIFont.Weight?) -> FontModifier
}

public struct FontModifier: ViewModifier {
    let fontName: String
    let size: CGFloat
    let lineSpacing: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: size))
            .lineSpacing(lineSpacing)
    }
}

