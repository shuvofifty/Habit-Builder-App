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
                    RegularTextFieldGroupView(headerText: "Email", value: $emailField, placeHolder: "john@habit.com", errorMsg: $viewModel.error[.emailFormat], focusedAction: {
                        if $0 == false {
                            let _ = viewModel.isValid(email: emailField)
                        }
                    })
                    
                    RegularTextFieldGroupView(isSecuredField: true, headerText: "Password", value: $password, placeHolder: "xxxxxxxxxxxx", errorMsg: $viewModel.error[.password], focusedAction: {
                        if $0 == false {
                            let _ = viewModel.isValid(password: password)
                        }
                    })
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
