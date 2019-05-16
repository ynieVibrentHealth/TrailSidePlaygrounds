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
        label.backgroundColor = .blue
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var secondLabel:UILabel = {
        let label = UILabel()
        label.text = "Second Text label"
        label.backgroundColor = .blue
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var rootFlexContainer:UIView = {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = .green
        return view
    }()
    
    fileprivate lazy var continueButton:UIButton = {
        let button = UIButton()
        button.setTitle("Press me", for: .normal)
        return button
    }()
    
    fileprivate lazy var buttonSubview:ButtonSubview = {
        let buttonSubview = ButtonSubview()
        return buttonSubview
    }()
    
    fileprivate lazy var buttonSubview2:ButtonSubview = {
        let buttonSubview = ButtonSubview()
        return buttonSubview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            flex.addItem().direction(.row).define({ (flex) in
                flex.addItem(continueButton)
                
                flex.addItem().direction(.column).grow(1).paddingLeft(15).define({ (flex) in
                    flex.addItem(label).grow(1)
                    flex.addItem(secondLabel).grow(1)
                })
            })
            
            flex.addItem().direction(.row).paddingTop(20).define({ (flex) in
                flex.addItem(buttonSubview).width(50%)
                flex.addItem(buttonSubview2).width(50%)
            })
        }
        
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

