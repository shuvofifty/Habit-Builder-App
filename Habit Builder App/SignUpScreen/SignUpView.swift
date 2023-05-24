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
    @State var emailField: String = ""
    
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
                        
                        TextField("Nothing??", text: $emailField)
                            .add(mod: .fullWidth())
                    }
                    
                    VStack(spacing: 5) {
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .add(mod: .fullWidth())
                        
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .add(mod: .fullWidth())
                    }
                    .padding(.top, 10)
                    
                    VStack(spacing: 10) {
                        Button("Lets get started") {
                            print("Create Account")
                        }
                        .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                        
                        Button("Already a member? Sign in") {
                            print("Create Account")
                        }
                        .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
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
        }
    }
}

struct SignUpView_Preview: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: Container.shared.signUpViewModel())
    }
}
