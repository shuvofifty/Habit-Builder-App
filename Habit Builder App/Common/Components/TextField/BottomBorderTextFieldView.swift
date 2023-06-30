//
//  BottomBorderTextFieldView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/30/23.
//

import Foundation
import SwiftUI

struct BottomBorderTextFieldView: View {
    var modifier: BottomBorderTextFieldModifier? = nil
    var isSecuredField: Bool = false
    @Binding var text: String
    var placeHolder: String? = nil
    var c: ColorSystem
    var f: FontSystem
    var focusedAction: ((_ isFocused: Bool) -> Void)? = nil
    
    @FocusState private var fieldFocusState: Bool
    
    var body: some View {
        if isSecuredField {
            SecureField("", text: $text, prompt: .placeHolder(text: placeHolder ?? "", c: c, f: f))
                .focused($fieldFocusState)
                .modifier(modifier ?? BottomBorderTextFieldModifier(fontSystem: f, colorSystem: c))
                .add(mod: .fullWidth())
                .onChange(of: fieldFocusState) { focusedAction?($0) }
                .onSubmit {
                    hideKeyboard()
                }
        } else {
            TextField("", text: $text, prompt: .placeHolder(text: placeHolder ?? "", c: c, f: f))
                .focused($fieldFocusState)
                .modifier(modifier ?? BottomBorderTextFieldModifier(fontSystem: f, colorSystem: c))
                .add(mod: .fullWidth())
                .onChange(of: fieldFocusState) { focusedAction?($0) }
                .onSubmit {
                    hideKeyboard()
                }
        }
    }
}
