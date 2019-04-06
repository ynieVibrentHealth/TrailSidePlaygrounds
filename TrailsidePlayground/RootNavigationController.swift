//
//  RootNavigationController.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/6/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit

class RootNavigationController:UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([ViewController()], animated: true)
    }
}
