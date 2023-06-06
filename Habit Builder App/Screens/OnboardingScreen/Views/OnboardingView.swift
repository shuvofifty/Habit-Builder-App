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
        case intro, name, welcome, firstHabit, why, reason, checkIn, checkInSuccess
    }
    
    @StateObject var viewModel: ViewModel
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
                    .onTapGesture {
                        viewModel.name = name
                    }
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
    
    var reasonView: some View {
        VStack(spacing: 0) {
            C.asset(.habitReasonHero)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 42)
                .padding(.top, 10)
            Text("Always Remember that!")
                .font(C.font.get(for: .h1, customWeight: nil))
                .foregroundColor(C.color.get(for: .secondary, .s2))
                .add(mod: .fullWidth())
                .padding(.bottom, 10)
            Text("Understanding the why while working on building a habit is important so that it keeps you motivated in long run")
                .font(C.font.get(for: .h3, customWeight: nil))
                .foregroundColor(C.color.get(for: .neutral, .main))
                .add(mod: .fullWidth())
            Spacer()
            Button("Continue") {
                print("Continue")
            }
            .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 20)
    }
    
    var checkInView: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Start with")
                .font(C.font.get(for: .h1, customWeight: nil))
                .foregroundColor(C.color.get(for: .secondary, .s1))
                .add(mod: .fullWidth())
                .padding(.bottom, 0)
            Text("Check In")
                .font(C.font.get(for: .custom(size: 60, lineSpace: 0), customWeight: .bold))
                .foregroundColor(C.color.get(for: .neutral, .main))
                .add(mod: .fullWidth())
                .padding(.bottom, 40)
            Text("It is also a habit")
                .font(C.font.get(for: .h3, customWeight: nil))
                .foregroundColor(C.color.get(for: .background, .s2))
                .add(mod: .fullWidth())
            Spacer()
            Button("Tap to Check in") {
                print("Continue")
            }
            .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 20)
    }
    
    var checkInSuccessView: some View {
        VStack(spacing: 0) {
            C.asset(.checkInHero)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10, leading: -20, bottom: 30, trailing: -20))
            Text("Perfect!")
                .font(C.font.get(for: .h2, customWeight: nil))
                .foregroundColor(C.color.get(for: .secondary, .s1))
                .add(mod: .fullWidth())
                .padding(.bottom, 10)
            Text("We added it for you")
                .font(C.font.get(for: .h1, customWeight: nil))
                .foregroundColor(C.color.get(for: .secondary, .s2))
                .add(mod: .fullWidth())
                .padding(.bottom, 10)
            Text("Everyday you open the app we will mark this habbit as done")
                .font(C.font.get(for: .secondaryElements, customWeight: nil))
                .foregroundColor(C.color.get(for: .neutral, .main))
                .add(mod: .fullWidth())
            Spacer()
            Button("Lets Begin") {
                print("Continue")
            }
            .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 20)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(C.color.get(for: .primary, .s4))
                .ignoresSafeArea()
            switch viewModel.activeStep {
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
            case .reason:
                reasonView
            case .checkIn:
                checkInView
            case .checkInSuccess:
                checkInSuccessView
            }
            
        }
        .onAppear {
            viewModel.startOnboardingProcess()
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: Container.shared.onboardingViewModel())
    }
}
