//
//  Config.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

final class Config {
    static let color: ColorSystem = OrangeHeavenColorSystem()
    static let font: FontSystem = RobotFontSystem()
    
    static func asset(_ asset: Assets) -> UIImage {
        UIImage(imageLiteralResourceName: asset.rawValue)
    }
    
    static func asset(_ asset: Assets) -> Image {
        Image(asset.rawValue)
    }
}
