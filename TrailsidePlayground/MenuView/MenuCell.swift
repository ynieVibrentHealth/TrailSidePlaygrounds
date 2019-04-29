//
//  MenuCell.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/29/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class MenuCell:UITableViewCell {
    static let REUSE_ID:String = "MenuCell_REUSE_ID"
    
    fileprivate lazy var flexContainer:UIView = {
        let view = UIView()

        self.contentView.addSubview(view)
        return view
    }()
    
    fileprivate lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    public func configure(with text:String) {
        contentLabel.text = text
        flexContainer.flex.direction(.row).padding(12).define({ (flex) in
            flex.addItem(contentLabel)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flexContainer.pin.top().left().right().bottom()
    }
}
