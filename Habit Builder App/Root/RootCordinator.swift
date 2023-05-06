//
//  RootCordinator.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/4/23.
//

import Foundation
import UIKit

class RootCordinatorImp: RootCordinator {
    lazy var landingCordinator: LandingCordinator = {
        LandingCordinatorImp(rootCordinator: self)
    }()
    
    var router: Router?
    
    init() {
        self.router = landingCordinator.getWithRouter()
    }
}
