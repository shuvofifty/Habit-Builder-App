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
            VStack {
                C.asset(.infoHeroIcon)
                    .frame(maxWidth: .infinity)
                
                Text("Habit Builder")
                    .modifier(C.font.get(for: .h1, customWeight: nil))
                    .foregroundColor(C.color.get(for: .primary, .s4))
                
                Text("Simple way to make great progress")
                    .modifier(C.font.get(for: .secondaryElements, customWeight: nil))
                    .foregroundColor(C.color.get(for: .text, .s1))
                
                Button("Create an account") {
                    print("Hahahaha")
                }.buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                
                Button("Member? Sign in") {
                    print("Hahahaha")
                }.buttonStyle(SecondaryButtonBorderedStyle(colorSystem: C.color, fontSystem: C.font))
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            
        }
    }
}
