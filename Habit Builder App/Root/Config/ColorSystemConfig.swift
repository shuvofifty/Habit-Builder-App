//
//  ColorSystemConfig.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

final class OrangeHeavenColorSystem: ColorSystem {
    func get(for type: ColorType, _ shade: ColorShades) -> Color {
        Color(uiColor: get(for: type, shade))
    }
    
    func get(for type: ColorType, _ shade: ColorShades) -> UIColor {
        switch type {
        case .primary:
            return getPrimary(for: shade)
        case .secondary:
            return getSecondary(for: shade)
        case .complementary:
            return getComplementary(for: shade)
        case .background:
            return getBackground(for: shade)
        case .text:
            return getText(for: shade)
        case .accent:
            return getAccent(for: shade)
        case .neutral:
            return getNeutral(for: shade)
        case .black:
            return UIColor(r: 0, g: 0, b: 0, a: 1)
        case .red:
            return UIColor(r: 235, g: 95, b: 95, a: 1)
        }
    }
    
    private func getPrimary(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 255, g: 167, b: 38, a: 1)
        case .s1:
            return UIColor(r: 255, g: 184, b: 77, a: 1)
        case .s2:
            return UIColor(r: 255, g: 167, b: 38, a: 1)
        case .s3:
            return UIColor(r: 255, g: 140, b: 0, a: 1)
        case .s4:
            return UIColor(r: 230, g: 115, b: 0, a: 1)
        }
    }
    
    private func getSecondary(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 255, g: 204, b: 128, a: 1)
        case .s1:
            return UIColor(r: 255, g: 218, b: 179, a: 1)
        case .s2:
            return UIColor(r: 255, g: 204, b: 128, a: 1)
        case .s3:
            return UIColor(r: 255, g: 183, b: 77, a: 1)
        case .s4:
            return UIColor(r: 255, g: 163, b: 51, a: 1)
        }
    }
    
    private func getComplementary(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 25, g: 118, b: 210, a: 1)
        case .s1:
            return UIColor(r: 99, g: 168, b: 255, a: 1)
        case .s2:
            return UIColor(r: 25, g: 128, b: 210, a: 1)
        case .s3:
            return UIColor(r: 21, g: 101, b: 192, a: 1)
        case .s4:
            return UIColor(r: 13, g: 71, b: 161, a: 1)
        }
    }
    
    private func getBackground(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 245, g: 245, b: 245, a: 1)
        case .s1:
            return UIColor(r: 247, g: 247, b: 247, a: 1)
        case .s2:
            return UIColor(r: 245, g: 245, b: 245, a: 1)
        case .s3:
            return UIColor(r: 224, g: 224, b: 224, a: 1)
        case .s4:
            return UIColor(r: 214, g: 214, b: 214, a: 1)
        }
    }
    
    private func getText(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 66, g: 66, b: 66, a: 1)
        case .s1:
            return UIColor(r: 97, g: 97, b: 97, a: 1)
        case .s2:
            return UIColor(r: 66, g: 66, b: 66, a: 1)
        case .s3:
            return UIColor(r: 33, g: 33, b: 33, a: 1)
        case .s4:
            return UIColor(r: 28, g: 28, b: 28, a: 1)
        }
    }
    
    private func getAccent(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 102, g: 187, b: 106, a: 1)
        case .s1:
            return UIColor(r: 129, g: 199, b: 132, a: 1)
        case .s2:
            return UIColor(r: 102, g: 187, b: 106, a: 1)
        case .s3:
            return UIColor(r: 76, g: 175, b: 80, a: 1)
        case .s4:
            return UIColor(r: 67, g: 160, b: 71, a: 1)
        }
    }
    
    private func getNeutral(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(r: 255, g: 255, b: 255, a: 1)
        case .s1:
            return UIColor(r: 255, g: 255, b: 255, a: 1)
        case .s2:
            return UIColor(r: 250, g: 250, b: 250, a: 1)
        case .s3:
            return UIColor(r: 240, g: 240, b: 240, a: 1)
        case .s4:
            return UIColor(r: 232, g: 232, b: 232, a: 1)
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
