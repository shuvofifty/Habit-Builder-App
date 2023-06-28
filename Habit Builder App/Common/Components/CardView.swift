//
//  CardView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/28/23.
//

import SwiftUI

public struct BaseCardView<Content: View>: View {
    var c: ColorSystem
    var f: FontSystem
    var content: Content
    
    init(c: ColorSystem, f: FontSystem, @ViewBuilder content: @escaping () -> Content) {
        self.c = c
        self.f = f
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            content
        }
        .padding(15)
        .background(c.get(for: .neutral, .main))
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCardView(c: C.color, f: C.font) {
            
        }
    }
}
