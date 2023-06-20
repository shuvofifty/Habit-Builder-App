//
//  SignInView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/20/23.
//

import Foundation
import SwiftUI
import UIKit

struct SignInView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text("String")
    }
}

struct SignInView_Preview: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInView.ViewModel())
    }
}

class SignInViewController: IDViewController, UIGestureRecognizerDelegate {
    var contentView: UIHostingController<SignInView>
    
    init(viewModel: SignInView.ViewModel) {
        self.contentView = UIHostingController(rootView: SignInView(viewModel: viewModel))
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
