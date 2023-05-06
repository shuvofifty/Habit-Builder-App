//
//  Router.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/3/23.
//

import Foundation
import UIKit

public protocol Router {
    var navigationController: UINavigationController { get }
    
    func push(_ view: UIViewController, animated: Bool)
}

public class RouterImp: Router {
    public let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func push(_ view: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(view, animated: animated)
    }
}
