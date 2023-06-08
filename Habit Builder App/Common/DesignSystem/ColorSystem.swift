//
//  ColorSystem.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

public enum ColorType {
    case primary, secondary, complementary, background, text, accent, neutral, black
}

public enum ColorShades {
    case main, s1, s2, s3, s4
}

public protocol ColorSystem {
    func get(for type: ColorType, _ shade: ColorShades) -> UIColor
    func get(for type: ColorType, _ shade: ColorShades) -> Color
}
