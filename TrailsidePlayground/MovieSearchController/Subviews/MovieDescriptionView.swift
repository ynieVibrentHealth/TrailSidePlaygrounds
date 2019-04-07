//
//  MovieDescriptionView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

class MovieDescriptionView:UIView {
    
    fileprivate lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 7
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    public func configure(with viewModel:MovieSearchViewModel) {
        self.descriptionLabel.text = viewModel.description
    }
    
    override func updateConstraints() {
        descriptionLabel.snp.updateConstraints { (make) in
            make.edges.equalTo(self).inset(15).priority(999)
        }
        super.updateConstraints()
    }

}
