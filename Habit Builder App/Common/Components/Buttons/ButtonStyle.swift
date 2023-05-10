//
//  ButtonStyle.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/9/23.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let colorSystem: ColorSystem
    let fontSystem: FontSystem
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Capsule().fill(colorSystem.get(for: .primary, .s3)))
    }
}
