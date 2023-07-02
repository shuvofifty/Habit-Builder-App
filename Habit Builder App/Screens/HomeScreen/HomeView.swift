//
//  HomeView.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/28/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            C.color.get(for: .background, .main)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Hi, \(viewModel.userName)")
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
                
                BaseCardView(c: C.color, f: C.font) {
                    HStack(spacing: 0) {
                        C.asset(.alertIcon)
                            .frame(width: 25, height: 20)
                            .padding(.trailing, 15)
                        
                        VStack(spacing: 0) {
                            Text("Drinking Water")
                                .modifier(C.font.get(for: .h3, customWeight: nil))
                                .foregroundColor(C.color.get(for: .text, .main))
                                .add(mod: .fullWidth())
                                .padding(.bottom, 5)
                            
                            Text("I want to develop a habit which will help me to maintain my body state and help me to grow")
                                .modifier(C.font.get(for: .smallText, customWeight: nil))
                                .foregroundColor(C.color.get(for: .text, .main))
                                .add(mod: .fullWidth())
                        }
                    }
                    .add(mod: .fullWidth())
                    .padding(.bottom, 25)
                    
                    Button("Check in") {
                        viewModel.cordinator.navigationController?.popViewController(animated: true)
                    }
                    .buttonStyle(PrimaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                    .add(mod: .fullWidth())
                    .padding(.bottom, 15)
                    
                    Button("Detail") {
                        
                    }
                    .buttonStyle(TertiaryButtonStyle(colorSystem: C.color, fontSystem: C.font))
                    .add(mod: .fullWidth())
                }
                .padding(.top, 17)
                
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
