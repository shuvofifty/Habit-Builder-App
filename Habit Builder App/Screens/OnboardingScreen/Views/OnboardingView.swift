//
//  OnboardingView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/24/23.
//

import Foundation
import Factory
import SwiftUI

struct OnboardingView: View {
    enum Step {
        case intro, name
    }
    
    @StateObject var viewModel: ViewModel
    @State var step: Step = .name
    @State var name: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(C.color.get(for: .primary, .s4))
                .ignoresSafeArea()
            switch step {
            case .intro:
                VStack(spacing: 10) {
                    Text("Perfect!")
                        .font(C.font.get(for: .h1, customWeight: nil))
                        .foregroundColor(C.color.get(for: .neutral, .main))
                        .add(mod: .fullWidth())
                    Text("You are already one step ahead")
                        .font(C.font.get(for: .h1, customWeight: nil))
                        .foregroundColor(C.color.get(for: .secondary, .s1))
                        .add(mod: .fullWidth())
                }
                .add(mod: .fullWidth())
                .padding(.horizontal, 20)
            case .name:
                VStack(spacing: 0) {
                    Text("Before we beign")
                        .font(C.font.get(for: .h1, customWeight: nil))
                        .foregroundColor(C.color.get(for: .secondary, .main))
                        .add(mod: .fullWidth())
                        .padding(.bottom, 10)
                    Text("What should I call you?")
                        .font(C.font.get(for: .h1, customWeight: nil))
                        .foregroundColor(C.color.get(for: .neutral, .main))
                        .add(mod: .fullWidth())
                        .padding(.bottom, 50)
                    
                    HStack(spacing: 15) {
                        TextField("", text: $name, prompt: .placeHolder(text: "Your name", c: C.color, f: C.font))
                            .modifier(BottomBorderTextFieldModifier(fontSystem: C.font, colorSystem: C.color))
                            .add(mod: .fullWidth())
                        C.asset(.smallNextButtonPrimary)
                            .frame(width: 40, height: 40)
                    }
                }
                .add(mod: .fullWidth())
                .padding(.horizontal, 20)
            }
            
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: Container.shared.onboardingViewModel())
    }
}
