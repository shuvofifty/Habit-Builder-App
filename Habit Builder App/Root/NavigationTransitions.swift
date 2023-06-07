//
//  NavigationTransitions.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/7/23.
//

import Foundation
import UIKit

enum TransitionStyle {
    case push, fadeIn
}

class FadeInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    weak var navController: UINavigationController?
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.3
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if transitionCompleted {
            navController?.delegate = nil
        }
    }
}
