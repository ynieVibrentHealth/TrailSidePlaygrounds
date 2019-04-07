//
//  MovieSearchResultCell.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MovieSearchResultCell:UITableViewCell {
    public static let REUSE_ID:String = "MovieSearchResultCellReuseId"
    
    fileprivate lazy var stackContainer:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        self.contentView.addSubview(stack)
        return stack
    }()
    
    fileprivate lazy var movieContentView:MovieContentView = MovieContentView()
    fileprivate lazy var descriptionView:MovieDescriptionView = MovieDescriptionView()
    
    public func configure(with viewModel:MovieSearchViewModel) {
        movieContentView.configure(with: viewModel)
        stackContainer.addArrangedSubview(movieContentView)
        
        descriptionView.configure(with: viewModel)
        stackContainer.addArrangedSubview(descriptionView)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        stackContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        super.updateConstraints()
    }
}
