//
//  BottomSheetModal.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/8/23.
//

import Foundation
import SwiftUI

public struct BottomSheetModalView<Content: View>: View {
    let c: ColorSystem
    var content: () -> Content
    
    @State var showContent: Bool = false
    
    init(c: ColorSystem, @ViewBuilder content: @escaping () -> Content) {
        self.c = c
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                content()
                    .offset(y: showContent ? 0 : geometry.size.height)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .add(mod: .fullWidth())
        .background(c.get(for: .black, .main).opacity(showContent ? 0.6 : 0))
        .onAppear {
            withAnimation(.spring()) {
                showContent = true
            }
        }
    }
}

struct BottomSheetModal_PreviewProvider: PreviewProvider {
    static var previews: some View {
        BottomSheetModalView(c: C.color) {
            LoaderView(c: C.color, f: C.font, title: "Something", description: "Something Fishy Something Fishy Something Fishy Something Fishy Something Fishy Something Fishy Something Fishy")
        }
    }
}
