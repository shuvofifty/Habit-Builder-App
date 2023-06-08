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
                        
                        TextField("", text: $emailField, prompt: .placeHolder(text: "john@habit.com", c: C.color, f: C.font))
                            .modifier(RegularTextFieldModifier(fontSystem: C.font, colorSystem: C.color))
                            .add(mod: .fullWidth())
                    }
                    
                    VStack(spacing: 5) {
                        Text("Password")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .add(mod: .fullWidth())
                        
                        SecureField("", text: $password, prompt: .placeHolder(text: "xxxxxxxxxxxx", c: C.color, f: C.font))
                            .modifier(RegularTextFieldModifier(fontSystem: C.font, colorSystem: C.color))
                            .add(mod: .fullWidth())
                    }
                    .padding(.top, 10)
                    
                    VStack(spacing: 10) {
                        Button("Lets get started") {
                            viewModel.cordinator.navigate(to: .onboarding, groupWith: .onBoarding, transition: .fadeIn)
                        }
                        .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                        .add(mod: .fullWidth())
                        
                        Button("Already a member? Sign in") {
                            viewModel.cordinator.showLoader(with: nil, description: nil)
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
