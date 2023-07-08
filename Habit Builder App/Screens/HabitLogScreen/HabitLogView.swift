//
//  HabitLogView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/8/23.
//

import Foundation
import SwiftUI

struct HabitLogView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text("Habit Log")
    }
}

struct HabitLogView_Preview: PreviewProvider {
    static var previews: some View {
        HabitLogView(viewModel: HabitLogView.ViewModel())
    }
}

class HomeLogViewController: IDViewController {
    var contentView: UIHostingController<HabitLogView>
    
    init(viewModel: HabitLogView.ViewModel) {
        self.contentView = UIHostingController(rootView: HabitLogView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = C.color.get(for: .background, .main)
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.hook(to: view, safeArea: true, with: 0)
    }
}
