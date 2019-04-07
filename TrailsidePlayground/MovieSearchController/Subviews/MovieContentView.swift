//
//  MovieContentView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

class MovieContentView:UIView {
    fileprivate lazy var moviePoster:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        return imageView
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    fileprivate lazy var directorLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        self.addSubview(label)
        return label
    }()
    
    fileprivate lazy var releaseDateLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        self.addSubview(label)
        return label
    }()
    
    fileprivate lazy var contentDescriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        self.addSubview(label)
        return label
    }()
    
    public func configure(with viewModel:MovieSearchViewModel) {
        moviePoster.kf.setImage(with: URL(string: viewModel.imageURLString))
        titleLabel.text = viewModel.title
        directorLabel.text = viewModel.director
        releaseDateLabel.text = viewModel.year
        contentDescriptionLabel.text = viewModel.contentInformation
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        moviePoster.snp.updateConstraints { (make) in
            make.width.equalTo(67).priority(999)
            make.height.equalTo(100).priority(999)
            make.leading.top.equalTo(self).inset(15).priority(999)
            make.bottom.equalTo(self).inset(10).priority(999)
        }
        
        titleLabel.snp.updateConstraints { (make) in
            make.leading.equalTo(moviePoster.snp.trailing).offset(10).priority(999)
            make.top.equalTo(moviePoster).priority(999)
            make.trailing.equalTo(self).inset(15).priority(999)
        }
        
        directorLabel.snp.updateConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5).priority(999)
            make.leading.trailing.equalTo(titleLabel).priority(999)
        }
        
        releaseDateLabel.snp.updateConstraints { (make) in
            make.top.equalTo(directorLabel.snp.bottom).offset(5).priority(999)
            make.leading.trailing.equalTo(titleLabel).priority(999)
        }
        
        contentDescriptionLabel.snp.updateConstraints { (make) in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(titleLabel)
        }
        super.updateConstraints()
    }
}
