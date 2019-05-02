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
import FlexLayout
import PinLayout

class MovieSearchResulLayouttCell:UITableViewCell {
    public static let REUSE_ID:String = "MovieSearchResulLayouttCellReuseId"
    
    fileprivate lazy var moviePoster:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    fileprivate lazy var directorLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    fileprivate lazy var releaseDateLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    fileprivate lazy var contentDescriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    fileprivate lazy var movieDescriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.flex.direction(.column).padding(10).define { (flex) in
            flex.addItem().direction(.row).define({ (flex) in
                flex.addItem(moviePoster).size(CGSize(width: 67, height: 100))
                
                flex.addItem().direction(.column).grow(1).shrink(1).define({ (flex) in
                    flex.addItem(titleLabel).marginLeft(10).grow(1)
                    flex.addItem(directorLabel).marginLeft(10).grow(1)
                    flex.addItem(releaseDateLabel).marginLeft(10).grow(1)
                    flex.addItem(contentDescriptionLabel).marginLeft(10).grow(1)
                })
            })
            flex.addItem().height(0.5).marginTop(10).grow(1).backgroundColor(.lightGray)
            flex.addItem(movieDescriptionLabel).grow(1).marginTop(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func configure(with viewModel:MovieSearchViewModel) {

        moviePoster.kf.setImage(with: URL(string: viewModel.imageURLString))
        titleLabel.text = viewModel.title
        titleLabel.flex.markDirty()
        directorLabel.text = viewModel.director
        directorLabel.flex.markDirty()
        releaseDateLabel.text = viewModel.year
        releaseDateLabel.flex.markDirty()
        contentDescriptionLabel.text = viewModel.contentInformation
        contentDescriptionLabel.flex.markDirty()
        movieDescriptionLabel.text = viewModel.description
        movieDescriptionLabel.flex.markDirty()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)
        
        // 2) Layout contentView flex container
        layout()
        
        // Return the flex container new size
        return contentView.frame.size
    }
}
