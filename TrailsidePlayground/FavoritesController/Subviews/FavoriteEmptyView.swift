//
//  FavoriteEmptyView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/8/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteEmptyView: UITableViewCell {
    static let REUSE_ID:String = "FavoriteEmptyViewREUSEID"
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var detailsLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .gray
        self.contentView.addSubview(label)
        return label
    }()
    
    public func configure(titleText:String, detailsText:String) {
        titleLabel.text = titleText
        detailsLabel.text = detailsText
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.contentView).inset(20)
            make.leading.trailing.equalTo(self.contentView).inset(30)
        }
        
        detailsLabel.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.contentView).inset(10)
        }
        super.updateConstraints()
    }
}
