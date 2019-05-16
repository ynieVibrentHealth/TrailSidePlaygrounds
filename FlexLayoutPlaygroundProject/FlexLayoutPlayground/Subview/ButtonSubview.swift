//
//  ButtonSubview.swift
//  FlexLayoutPlayground
//
//  Created by Yuchen Nie on 5/16/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

class ButtonSubview:UIView {
    
    fileprivate lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        self.addSubview(view)
        return view
    }()
    
    fileprivate lazy var button:UIButton = {
        let button = UIButton()
        button.setTitle("Press Me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.flex.addItem()
            .direction(.column)
            .paddingTop(10).paddingBottom(10).paddingRight(12).paddingLeft(12)
            .define { (flex) in
            flex.addItem(button).grow(1)
        }
        
        containerView.pin.all()
        containerView.flex.layout(mode: .adjustHeight)
    }
}
