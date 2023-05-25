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
        case intro, name, welcome, firstHabit, why
    }
    
    @StateObject var viewModel: ViewModel
    @State var step: Step = .why
    @State var name: String = ""
    @State var whyDescription: String = ""
    
    var introView: some View {
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
    }
    
    var nameView: some View {
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
    
    var welcomeView: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Hello John")
                .font(C.font.get(for: .h1, customWeight: nil))
                .foregroundColor(C.color.get(for: .neutral, .main))
                .add(mod: .fullWidth())
                .padding(.bottom, 10)
            Text("Today we mark the first step in your journey")
                .font(C.font.get(for: .h2, customWeight: nil))
                .foregroundColor(C.color.get(for: .secondary, .s1))
                .add(mod: .fullWidth())
                .padding(.bottom, 91)
            
            HStack {
                C.asset(.helloNameHero)
                    .resizable()
                    .frame(width: 333, height: 431)
            }
            .add(mod: .fullWidth(alignment: .trailing))
            .padding(.trailing, -20)
            
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 20)
    }
    
    var firstHabitView: some View {
        VStack(spacing: 0) {
            Text("Tell Us")
                .font(C.font.get(for: .h1, customWeight: nil))
                .foregroundColor(C.color.get(for: .secondary, .main))
                .add(mod: .fullWidth())
                .padding(.bottom, 10)
            Text("Whats the first habit you want to develop?")
                .font(C.font.get(for: .h2, customWeight: nil))
                .foregroundColor(C.color.get(for: .neutral, .main))
                .add(mod: .fullWidth())
                .padding(.bottom, 50)
            
            HStack(spacing: 15) {
                TextField("", text: $name, prompt: .placeHolder(text: "Drink water every morning", c: C.color, f: C.font))
                    .modifier(RegularTextFieldModifier(fontSystem: C.font, colorSystem: C.color))
                    .add(mod: .fullWidth())
                C.asset(.smallNextButtonPrimary)
                    .frame(width: 40, height: 40)
            }
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 20)
    }
    
    var whyView: some View {
        VStack(spacing: 0) {
            Text("Why?")
                .font(C.font.get(for: .h1, customWeight: nil))
                .foregroundColor(C.color.get(for: .neutral, .main))
                .add(mod: .fullWidth())
                .padding(.bottom, 20)
            
            HStack(spacing: 15) {
                TextField("", text: $whyDescription, prompt: .placeHolder(text: "Because I want to reach my daily water intake goal and always live a healthy life", c: C.color, f: C.font), axis: .vertical)
                    .lineLimit(7, reservesSpace: true)
                    .modifier(RegularTextFieldModifier(fontSystem: C.font, colorSystem: C.color, height: 150))
                    .add(mod: .fullWidth())
                C.asset(.smallNextButtonPrimary)
                    .frame(width: 40, height: 40)
            }
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 20)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(C.color.get(for: .primary, .s4))
                .ignoresSafeArea()
            switch step {
            case .intro:
                introView
            case .name:
                nameView
            case .welcome:
                welcomeView
            case .firstHabit:
                firstHabitView
            case .why:
                whyView
            }
            
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: Container.shared.onboardingViewModel())
    }
}
