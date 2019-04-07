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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    fileprivate lazy var dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        self.addSubview(view)
        return view
    }()
    
    public func configure(with viewModel:MovieSearchViewModel, numberOfLinesLimit:Int = 7) {
        self.descriptionLabel.numberOfLines = numberOfLinesLimit
        self.descriptionLabel.text = viewModel.description
    }
    
    override func updateConstraints() {
        descriptionLabel.snp.updateConstraints { (make) in
            make.edges.equalTo(self).inset(15).priority(999)
        }
        
        dividerLine.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(self).inset(15).priority(999)
            make.bottom.equalTo(self).priority(999)
            make.height.equalTo(0.5)
        }
        
        super.updateConstraints()
    }

}
