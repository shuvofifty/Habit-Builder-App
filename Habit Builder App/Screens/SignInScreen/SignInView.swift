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
    @State private var emailField: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            C.color.get(for: .background, .main)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Lets get started on tracking down your habits")
                    .modifier(C.font.get(for: .h2, customWeight: nil))
                    .foregroundColor(C.color.get(for: .primary, .s4))
                    .add(mod: .fullWidth())
                
                VStack(spacing: 0) {
                    RegularTextFieldGroupView(headerText: "Email", value: $emailField, placeHolder: "john@habit.com", errorMsg: $viewModel.error[.emailFormat], focusedAction: {
                        if $0 == false {
                            let _ = viewModel.isValid(email: emailField)
                        }
                    })
                    
                    RegularTextFieldGroupView(isSecuredField: true, headerText: "Password", value: $password, placeHolder: "xxxxxxxxxxxx", errorMsg: $viewModel.error[.password], focusedAction: {
                        if $0 == false {
                            let _ = viewModel.isValid(password: password)
                        }
                    })
                    .padding(.top, 10)
                    
                    VStack(spacing: 10) {
                        Button("Continue") {
                            hideKeyboard()
                            viewModel.continueButtonTapped(email: emailField, password: password)
                        }
                        .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                        .add(mod: .fullWidth())
                        
                        Button("Forgot Password?") {
                            hideKeyboard()
                        }
                        .buttonStyle(TertiaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                        .add(mod: .fullWidth())
                    }
                    .padding(.top, 30)
                }
                .padding(.top, 40)
                
                Spacer()
                
                C.asset(.loginHero)
                    .add(mod: .fullWidth(alignment: .center))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 26)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .onAppear { viewModel.setupStoreBindings() }
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
