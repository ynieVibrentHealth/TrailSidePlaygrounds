//
//  ViewController.swift
//  FlexLayoutPlayground
//
//  Created by Yuchen Nie on 5/13/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class ViewController: UIViewController {
    fileprivate lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Text label"
        label.backgroundColor = .green
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.pin.top().left().right().height(100)
    }
}

