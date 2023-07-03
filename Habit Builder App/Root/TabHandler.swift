//
//  TabHandler.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/2/23.
//

import Foundation
import UIKit

protocol TabHandler {
    var tabBarController: UITabBarController? { get }
    
    func intiateTabBar(with tabItems: [(tag: Int, tab: Tab)])
    func getSelectedTab() -> Tab
}

class TabHandlerImp: TabHandler {
    private class CustomTabBar: UITabBar {
        let tabBarHeight: CGFloat = 80

        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = tabBarHeight
            return sizeThatFits
        }
    }
    
    var tabBarController: UITabBarController?
    private var tabItems: [(tag: Int, tab: Tab)] = []
    
    func intiateTabBar(with tabItems: [(tag: Int, tab: Tab)]) {
        guard tabBarController == nil else {
            print("Tab Bar already exist. De-init tab bar before creating one")
            return
        }
        tabBarController = UITabBarController()
        tabBarController?.setValue(CustomTabBar(), forKeyPath: "tabBar")
        
        var viewControllers: [UIViewController] = []
        self.tabItems = tabItems
        
        for tabItem in tabItems {
            switch tabItem.tab {
            case .home(let homeNav):
                homeNav.tabBarItem = UITabBarItem(title: nil, image: C.asset(.homeSelected).withRenderingMode(.alwaysOriginal), tag: tabItem.tag)
                homeNav.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -25, right: 0)
                viewControllers.append(homeNav)
            }
        }
        tabBarController?.viewControllers = viewControllers
        changeTabBarColor()
    }
    
    private func changeTabBarColor() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = C.color.get(for: .text, .s2)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func getSelectedTab() -> Tab {
        guard let selectedIndex = tabBarController?.selectedIndex else {
            fatalError("Trying to access selected when tab bar is not intiated or deleted")
        }
        for tabItem in tabItems {
            if tabItem.tag == selectedIndex {
                return tabItem.tab
            }
        }
        fatalError("Tab item and selected index \(selectedIndex) doesn't match. Please check your tab intiate")
    }
}

enum Tab{
    case home(_ navController: UINavigationController)
}
