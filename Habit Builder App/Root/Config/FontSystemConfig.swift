//
//  FontSystemConfig.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

final class RobotFontSystem: FontSystem {
    func get(for type: FontType, customWeight: UIFont.Weight?) -> Font {
        Font(get(for: type, customWeight: customWeight))
    }
    
    func get(for type: FontType, customWeight: UIFont.Weight?) -> UIFont {
        switch type {
        case .body:
            return UIFont(name: getFontName(with: customWeight ?? .regular), size: 16)!
        case .h1:
            return UIFont(name: getFontName(with: customWeight ?? .bold), size: 28)!
        case .h2:
            return UIFont(name: getFontName(with: customWeight ?? .bold), size: 22)!
        case .h3:
            return UIFont(name: getFontName(with: customWeight ?? .medium), size: 18)!
        case .secondaryElements:
            return UIFont(name: getFontName(with: customWeight ?? .medium), size: 16)!
        case .successMessage:
            return UIFont(name: getFontName(with: customWeight ?? .medium), size: 16)!
        case .smallText:
            return UIFont(name: getFontName(with: customWeight ?? .regular), size: 14)!
        case .xSmallText:
            return UIFont(name: getFontName(with: customWeight ?? .regular), size: 12)!
        case .custom(let size, _):
            return UIFont(name: getFontName(with: customWeight ?? .regular), size: size)!
        }
    }
    
    func get(for type: FontType, customWeight: UIFont.Weight?) -> FontModifier {
        switch type {
        case .body:
            return FontModifier(fontName: getFontName(with: customWeight ?? .regular), size: 16, lineSpacing: 0)
        case .h1:
            return FontModifier(fontName: getFontName(with: customWeight ?? .bold), size: 28, lineSpacing: 0)
        case .h2:
            return FontModifier(fontName: getFontName(with: customWeight ?? .bold), size: 22, lineSpacing: 0)
        case .h3:
            return FontModifier(fontName: getFontName(with: customWeight ?? .medium), size: 18, lineSpacing: 0)
        case .secondaryElements:
            return FontModifier(fontName: getFontName(with: customWeight ?? .medium), size: 16, lineSpacing: 0)
        case .successMessage:
            return FontModifier(fontName: getFontName(with: customWeight ?? .medium), size: 16, lineSpacing: 0)
        case .smallText:
            return FontModifier(fontName: getFontName(with: customWeight ?? .regular), size: 14, lineSpacing: 0)
        case .xSmallText:
            return FontModifier(fontName: getFontName(with: customWeight ?? .regular), size: 12, lineSpacing: 0)
        case .custom(let size, let lineSpace):
            return FontModifier(fontName: getFontName(with: customWeight ?? .regular), size: size, lineSpacing: lineSpace)
        }
    }
    
    private func getFontName(with weight: UIFont.Weight?) -> String {
        guard let weight = weight else {
            return "Roboto-Regular"
        }
        
        switch weight {
        case .medium:
            return "Roboto-Medium"
        case .bold:
            return "Roboto-Bold"
        default:
            return "Roboto-Regular"
        }
    }
}
