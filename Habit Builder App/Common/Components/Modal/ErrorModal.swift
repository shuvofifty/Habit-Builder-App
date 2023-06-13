//
//  ErrorModal.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/13/23.
//

import Foundation
import SwiftUI
import Lottie

public struct ErrorModalView: View {
    let c: ColorSystem
    let f: FontSystem
    let title: String
    let description: String
    let continueButtonTapped: () -> Void
    
    public var body: some View {
        VStack {
            LottiAnimationWrapper(animationView: getAnimation())
                .frame(width: 100, height: 100)
                .padding(.bottom, 0)
            Text(title)
                .modifier(f.get(for: .h2, customWeight: nil))
                .add(mod: .fullWidth(alignment: .center))
                .padding(.bottom, 10)
            Text(description)
                .modifier(f.get(for: .smallText, customWeight: nil))
                .add(mod: .fullWidth())
            Button("Continue") {
                continueButtonTapped()
            }
            .buttonStyle(PrimaryButtonStyle(colorSystem: c, fontSystem: f))
            .padding(.top, 30)
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .background(c.get(for: .background, .main))
    }
    
    private func getAnimation() -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "errorModalAnimation")
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.8
        
        return animationView
    }
}


struct ErrorModalView_Preview: PreviewProvider {
    static var previews: some View {
        ErrorModalView(c: C.color, f: C.font, title: "Loading", description: "Sometimes it needs to do something we can all good stuff", continueButtonTapped: {})
    }
}
