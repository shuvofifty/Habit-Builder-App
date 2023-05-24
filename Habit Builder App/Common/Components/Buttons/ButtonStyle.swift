//
//  ButtonStyle.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/9/23.
//

import Foundation
import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    let colorSystem: ColorSystem
    let fontSystem: FontSystem
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Capsule().fill(colorSystem.get(for: .primary, .s3)))
            .font(fontSystem.get(for: .secondaryElements, customWeight: nil))
            .foregroundColor(colorSystem.get(for: .neutral, .main))
    }
}

public struct PrimaryButtonBorderedStyle: ButtonStyle {
    let colorSystem: ColorSystem
    let fontSystem: FontSystem
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .overlay(Capsule().stroke(colorSystem.get(for: .complementary, .main), lineWidth: 2))
            .font(fontSystem.get(for: .secondaryElements, customWeight: nil))
            .foregroundColor(colorSystem.get(for: .neutral, .main))
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    let colorSystem: ColorSystem
    let fontSystem: FontSystem
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Capsule().fill(colorSystem.get(for: .complementary, .s3)))
            .font(fontSystem.get(for: .secondaryElements, customWeight: nil))
            .foregroundColor(colorSystem.get(for: .neutral, .main))
    }
}

public struct SecondaryButtonBorderedStyle: ButtonStyle {
    let colorSystem: ColorSystem
    let fontSystem: FontSystem
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .overlay(Capsule().stroke(colorSystem.get(for: .complementary, .main), lineWidth: 2))
            .font(fontSystem.get(for: .secondaryElements, customWeight: nil))
            .foregroundColor(colorSystem.get(for: .text, .main))
    }
}

public struct TertiaryButtonStyle: ButtonStyle {
    let colorSystem: ColorSystem
    let fontSystem: FontSystem
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background(.clear)
            .font(fontSystem.get(for: .secondaryElements, customWeight: nil))
            .foregroundColor(colorSystem.get(for: .complementary, .main))
    }
}
