//
//  Router.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/3/23.
//

import Foundation
import UIKit

public protocol Router {
    var navigationController: UINavigationController? { get set }
    
    func push(_ view: UIViewController, animated: Bool)
    func push(_ router: Router, animated: Bool)
}

public class RouterImp: Router {
    public var navigationController: UINavigationController?
    
    public func push(_ view: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(view, animated: animated)
    }
    
    public func push(_ router: Router, animated: Bool) {
        guard let nav = router.navigationController else {
            fatalError("Cannot find navigation controller for router")
        }
        navigationController?.pushViewController(nav, animated: true)
    }
}
