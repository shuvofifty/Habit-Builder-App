//
//  SignUpView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            C.color.get(for: .background, .main)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("It gets easier now to track your progress")
                    .modifier(C.font.get(for: .h2, customWeight: nil))
                    .foregroundColor(C.color.get(for: .primary, .s4))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 0) {
                    VStack(spacing: 5) {
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack(spacing: 5) {
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Email")
                            .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                            .foregroundColor(C.color.get(for: .text, .main))
                            .frame(maxWidth: .infinity, alignment: .leading)
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
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
    }
}
