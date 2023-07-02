//
//  TabHandler.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 7/2/23.
//

import Foundation
import UIKit

protocol TabHandler {
    func intiateTabBar(with tabItems: [(tag: Int, tab: Tab)])
    func getSelectedTab() -> Tab
}

class TabHandlerImp: TabHandler {
    private var tabBarController: UITabBarController?
    private var tabItems: [(tag: Int, tab: Tab)] = []
    
    func intiateTabBar(with tabItems: [(tag: Int, tab: Tab)]) {
        guard tabBarController == nil else {
            print("Tab Bar already exist. De-init tab bar before creating one")
            return
        }
        tabBarController = UITabBarController()
        tabBarController?.viewControllers = []
        self.tabItems = tabItems
        
        for tabItem in tabItems {
            switch tabItem.tab {
            case .home(let homeNav):
                homeNav.tabBarItem = UITabBarItem(title: nil, image: C.asset(.homeSelected), tag: tabItem.tag)
                tabBarController?.viewControllers?.append(homeNav)
            }
        }
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
