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
    
    fileprivate lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .darkGray
        label.numberOfLines = 0
        self.contentView.flex.padding(12).define({ (flex) in
            flex.addItem(label).margin(10, 5, 10, 5)
        })
        return label
    }()
    
    public func configure(with text:String) {
        contentLabel.text = text
        contentLabel.flex.markDirty()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
    
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
}
