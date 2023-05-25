//
//  TextFieldStyle.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/24/23.
//

import Foundation
import SwiftUI

public struct RegularTextFieldModifier: ViewModifier {
    let fontSystem: FontSystem
    let colorSystem: ColorSystem
    var height: CGFloat = 44
    
    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .background(RoundedRectangle(cornerRadius: 10.0).fill(colorSystem.get(for: .neutral, .main)))
            .foregroundColor(colorSystem.get(for: .text, .main))
            .font(fontSystem.get(for: .body, customWeight: nil))
    }
}

public struct BottomBorderTextFieldModifier: ViewModifier {
    let fontSystem: FontSystem
    let colorSystem: ColorSystem
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(.clear)
            .overlay(content: {
                VStack{Rectangle().fill(colorSystem.get(for: .neutral, .main)).frame(height: 3).offset(x: 0, y: 20)}
            })
            .foregroundColor(colorSystem.get(for: .neutral, .main))
            .font(fontSystem.get(for: .body, customWeight: nil))
    }
}

extension View {
    static func placeHolder(text: String, c: ColorSystem, f: FontSystem) -> Text {
        Text(text)
            .foregroundColor(c.get(for: .background, .s4))
            .font(f.get(for: .body, customWeight: nil))
    }
}
