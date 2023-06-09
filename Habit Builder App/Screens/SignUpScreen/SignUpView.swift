//
//  SignUpView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import Factory
import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: ViewModel
    @State private var emailField: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            C.color.get(for: .background, .main)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("It gets easier now to track your progress")
                    .modifier(C.font.get(for: .h2, customWeight: nil))
                    .foregroundColor(C.color.get(for: .primary, .s4))
                    .add(mod: .fullWidth())
                
                VStack(spacing: 0) {
                    VStack(spacing: 5) {
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .add(mod: .fullWidth())
                        
                        if let errorMsg = viewModel.error[.emailFormat] {
                            Text(errorMsg)
                                .modifier(C.font.get(for: .smallText, customWeight: nil))
                                .foregroundColor(C.color.get(for: .red, .main))
                                .add(mod: .fullWidth())
                        }
                        RegularTextFieldView(text: $emailField, placeHolder: "john@habit.com", c: C.color, f: C.font, focusedAction: { isFocused in
                            if isFocused == false {
                                let _ = viewModel.isValid(email: emailField)
                            }
                        })
                    }
                    
                    VStack(spacing: 5) {
                        Text("Password")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .add(mod: .fullWidth())
                        
                        if let errorMsg = viewModel.error[.password] {
                            Text(errorMsg)
                                .modifier(C.font.get(for: .smallText, customWeight: nil))
                                .foregroundColor(C.color.get(for: .red, .main))
                                .add(mod: .fullWidth())
                        }
                        RegularTextFieldView(isSecuredField: true, text: $password, placeHolder: "xxxxxxxxxxxx", c: C.color, f: C.font, focusedAction: { isFocused in
                            if isFocused == false {
                                let _ = viewModel.isValid(password: password)
                            }
                        })
                    }
                    .padding(.top, 10)
                    
                    VStack(spacing: 10) {
                        Button("Lets get started") {
                            viewModel.continueButtonTapped(email: emailField, password: password)
                        }
                        .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                        .add(mod: .fullWidth())
                        
                        Button("Already a member? Sign in") {
                            viewModel.showModal()
                        }
                        .buttonStyle(TertiaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                        .add(mod: .fullWidth())
                    }
                    .padding(.top, 30)
                }
                .padding(.top, 40)
                
                Spacer()
                
                C.asset(.accountHeroImage)
                    .add(mod: .fullWidth(alignment: .center))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 26)
        }
    }
}

struct SignUpView_Preview: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: Container.shared.signUpViewModel())
    }
}
