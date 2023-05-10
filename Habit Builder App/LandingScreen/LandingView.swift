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
            Config.color.get(for: .background, .main)
                .ignoresSafeArea()
            VStack {
                Config.asset(.infoHeroIcon)
                    .frame(maxWidth: .infinity)
                
                Text("Habit Builder")
                    .modifier(Config.font.get(for: .h1, customWeight: nil))
                    .foregroundColor(Config.color.get(for: .primary, .s4))
                
                Text("Simple way to make great progress")
                    .modifier(Config.font.get(for: .secondaryElements, customWeight: nil))
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            
        }
    }
}
