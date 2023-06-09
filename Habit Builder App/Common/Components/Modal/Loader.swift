//
//  Loader.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/8/23.
//

import Foundation
import SwiftUI
import Lottie

public struct LoaderView: View {
    let c: ColorSystem
    let f: FontSystem
    let title: String
    let description: String
    
    public var body: some View {
        VStack {
            LottiAnimationWrapper(animationView: getLoaderAnimation())
                .frame(width: 200, height: 100)
                .padding(.bottom, 20)
            Text(title)
                .modifier(f.get(for: .h2, customWeight: nil))
                .add(mod: .fullWidth(alignment: .center))
                .padding(.bottom, 10)
            Text(description)
                .modifier(f.get(for: .secondaryElements, customWeight: nil))
                .add(mod: .fullWidth())
        }
        .add(mod: .fullWidth())
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .background(c.get(for: .background, .main))
    }
    
    private func getLoaderAnimation() -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "loader")
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.8
        
        return animationView
    }
}


struct LoaderView_Preview: PreviewProvider {
    static var previews: some View {
        LoaderView(c: C.color, f: C.font, title: "Loading", description: "Sometimes it needs to do something we can all good stuff")
    }
}

struct LottiAnimationWrapper: UIViewRepresentable {
    var animationView: LottieAnimationView
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
