//
//  BaseRouter.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class BaseRouter {
    
    func push(viewController: UIViewController, animated: Bool = true) {
        UIViewController.getCurrentNavigationController()?.pushViewController(viewController,
                                                                              animated: animated)
    }
}
