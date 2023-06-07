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
        window?.rootViewController = Container
                                        .shared
                                        .rootCordinator()
                                        .get(
                                            for: .regular,
                                            ifNotPresentGetwith: .landing
                                        )
                                        .navigationController
        window?.makeKeyAndVisible()
    }
}
