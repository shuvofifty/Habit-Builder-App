//
//  HomeView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/28/23.
//

import SwiftUI

struct HomeView: View {
    var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            C.color.get(for: .background, .main)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Hi, Shubroto")
                    .modifier(C.font.get(for: .custom(size: 38, lineSpace: 0), customWeight: .bold))
                    .foregroundColor(C.color.get(for: .primary, .s3))
                    .add(mod: .fullWidth(alignment: .trailing))
                
                HStack {
                    C.asset(.homeScreenHero)
                        .frame(width: 196, height: 302)
                        .padding(.leading, -20)
                    
                    Spacer()
                    
                    VStack {
                        Text("1/3")
                            .modifier(C.font.get(for: .custom(size: 48, lineSpace: 0), customWeight: .medium))
                            .foregroundColor(C.color.get(for: .text, .s2))
                            .add(mod: .fullWidth(alignment: .center))
                        
                        Text("Habit Completed")
                            .modifier(C.font.get(for: .h3, customWeight: nil))
                            .foregroundColor(C.color.get(for: .complementary, .s2))
                            .add(mod: .fullWidth(alignment: .center))
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeView.ViewModel())
    }
}

class HomeViewController: IDViewController {
    var contentView: UIHostingController<HomeView>
    
    init(viewModel: HomeView.ViewModel) {
        self.contentView = UIHostingController(rootView: HomeView(viewModel: viewModel))
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
    }
}
