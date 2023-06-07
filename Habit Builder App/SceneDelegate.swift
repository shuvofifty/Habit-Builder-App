//
//  SceneDelegate.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/2/23.
//

import Foundation
import Factory
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        var rootCordinator = Container.shared.rootCordinator()
        rootCordinator.navigationController = UINavigationController(rootViewController: rootCordinator.get(for: .landing))
        window?.rootViewController = rootCordinator.navigationController
        window?.makeKeyAndVisible()
    }
}
