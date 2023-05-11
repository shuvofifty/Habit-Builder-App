//
//  LandingView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import SwiftUI

struct LandingView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            C.color.get(for: .background, .main)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                C.asset(.infoHeroIcon)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 23)
                
                VStack(spacing: 0) {
                    Text("Habit Builder")
                        .modifier(C.font.get(for: .h1, customWeight: nil))
                        .foregroundColor(C.color.get(for: .primary, .s4))
                    
                    Text("Simple way to make great progress")
                        .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                        .foregroundColor(C.color.get(for: .text, .s1))
                }
                .padding(.top, 37)
                
                VStack(spacing: 15) {
                    Button("Create an account") {
                        viewModel.cordinator.navigateToSignUp()
                    }.buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                    
                    Button("Member? Sign in") {
                        print("Hahahaha")
                    }.buttonStyle(SecondaryButtonBorderedStyle(colorSystem: C.color, fontSystem: C.font))
                }
                .padding(.top, 30)
                
                Spacer()
                
                Text("Prod | Version 0.0.1")
                    .modifier(C.font.get(for: .xSmallText, customWeight: nil))
                    .foregroundColor(C.color.get(for: .text, .s1))
            }
            .padding(.horizontal, 20)
            
            
        }
    }
}
