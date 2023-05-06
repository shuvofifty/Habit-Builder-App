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
        Text("Morem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.")
            .modifier(Config.font.get(for: .body, customWeight: nil))
    }
}
