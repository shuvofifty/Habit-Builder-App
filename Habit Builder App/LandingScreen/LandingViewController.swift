//
//  LandingViewController.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/6/23.
//

import Foundation
import UIKit
import SwiftUI

class LandingViewController: UIViewController {
    var contentView: UIHostingController<LandingView>
    
    init(viewModel: LandingView.ViewModel) {
        self.contentView = UIHostingController(rootView: LandingView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.hook(to: view, with: 0)
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
}
