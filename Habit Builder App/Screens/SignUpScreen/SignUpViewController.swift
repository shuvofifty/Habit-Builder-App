//
//  SignUpViewController.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/10/23.
//

import Foundation
import UIKit
import SwiftUI

class SignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    var contentView: UIHostingController<SignUpView>
    
    init(viewModel: SignUpView.ViewModel) {
        self.contentView = UIHostingController(rootView: SignUpView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: C.asset(.backButton).withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: navigationController,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.hook(to: view, with: 0)
    }
}
