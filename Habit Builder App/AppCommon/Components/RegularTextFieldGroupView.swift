//
//  RegularTextFieldGroupView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/9/23.
//

import Foundation
import SwiftUI

struct RegularTextFieldGroupView: View {
    var isSecuredField: Bool = false
    var headerText: String
    @Binding var value: String
    var placeHolder: String? = nil
    @Binding var errorMsg: String?
    var focusedAction: ((_ isFocused: Bool) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 5) {
            Text(headerText)
                .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                .foregroundColor(C.color.get(for: .text, .main))
                .add(mod: .fullWidth())
            
            if let msg = errorMsg {
                Text(msg)
                    .modifier(C.font.get(for: .smallText, customWeight: nil))
                    .foregroundColor(C.color.get(for: .red, .main))
                    .add(mod: .fullWidth())
            }
            RegularTextFieldView(isSecuredField: isSecuredField, text: $value, placeHolder: placeHolder, c: C.color, f: C.font, focusedAction: focusedAction)
        }
    }
}
