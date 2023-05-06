//
//  ColorSystemConfig.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit

class OrangeHeavenColorSystem: ColorSystem {
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
        }
    }
    
    private func getPrimary(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 255, green: 167, blue: 38, alpha: 1)
        case .s1:
            return UIColor(red: 255, green: 184, blue: 77, alpha: 1)
        case .s2:
            return UIColor(red: 255, green: 167, blue: 38, alpha: 1)
        case .s3:
            return UIColor(red: 255, green: 140, blue: 0, alpha: 1)
        case .s4:
            return UIColor(red: 230, green: 115, blue: 0, alpha: 1)
        }
    }
    
    private func getSecondary(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 255, green: 204, blue: 128, alpha: 1)
        case .s1:
            return UIColor(red: 255, green: 218, blue: 179, alpha: 1)
        case .s2:
            return UIColor(red: 255, green: 204, blue: 128, alpha: 1)
        case .s3:
            return UIColor(red: 255, green: 183, blue: 77, alpha: 1)
        case .s4:
            return UIColor(red: 255, green: 163, blue: 51, alpha: 1)
        }
    }
    
    private func getComplementary(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 25, green: 118, blue: 210, alpha: 1)
        case .s1:
            return UIColor(red: 99, green: 168, blue: 255, alpha: 1)
        case .s2:
            return UIColor(red: 25, green: 128, blue: 210, alpha: 1)
        case .s3:
            return UIColor(red: 21, green: 101, blue: 192, alpha: 1)
        case .s4:
            return UIColor(red: 13, green: 71, blue: 161, alpha: 1)
        }
    }
    
    private func getBackground(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        case .s1:
            return UIColor(red: 247, green: 247, blue: 247, alpha: 1)
        case .s2:
            return UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        case .s3:
            return UIColor(red: 224, green: 224, blue: 224, alpha: 1)
        case .s4:
            return UIColor(red: 214, green: 214, blue: 214, alpha: 1)
        }
    }
    
    private func getText(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 66, green: 66, blue: 66, alpha: 1)
        case .s1:
            return UIColor(red: 97, green: 97, blue: 97, alpha: 1)
        case .s2:
            return UIColor(red: 66, green: 66, blue: 66, alpha: 1)
        case .s3:
            return UIColor(red: 33, green: 33, blue: 33, alpha: 1)
        case .s4:
            return UIColor(red: 28, green: 28, blue: 28, alpha: 1)
        }
    }
    
    private func getAccent(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 102, green: 187, blue: 106, alpha: 1)
        case .s1:
            return UIColor(red: 129, green: 199, blue: 132, alpha: 1)
        case .s2:
            return UIColor(red: 102, green: 187, blue: 106, alpha: 1)
        case .s3:
            return UIColor(red: 76, green: 175, blue: 80, alpha: 1)
        case .s4:
            return UIColor(red: 67, green: 160, blue: 71, alpha: 1)
        }
    }
    
    private func getNeutral(for shade: ColorShades) -> UIColor {
        switch shade {
        case .main:
            return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        case .s1:
            return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        case .s2:
            return UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        case .s3:
            return UIColor(red: 240, green: 240, blue: 240, alpha: 1)
        case .s4:
            return UIColor(red: 232, green: 232, blue: 232, alpha: 1)
        }
    }
}
