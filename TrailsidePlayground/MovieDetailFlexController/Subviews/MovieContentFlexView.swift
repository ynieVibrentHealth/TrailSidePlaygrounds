//
//  MovieContentFlexView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 5/13/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//
//
//import UIKit
//import PinLayout
//import FlexLayout
//
//class MovieContentFlexView:UIView {
//    fileprivate lazy var rootFlexContainer:UIView = {
//        let view = UIView()
//        view.backgroundColor = .blue
//        self.addSubview(view)
//        return view
//    }()
//
//    fileprivate lazy var moviePoster:UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//    fileprivate lazy var titleLabel:UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textColor = .black
//        return label
//    }()
//
//    fileprivate lazy var directorLabel:UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        return label
//    }()
//
//    fileprivate lazy var releaseDateLabel:UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        return label
//    }()
//
//    fileprivate lazy var contentDescriptionLabel:UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .gray
//        return label
//    }()
//
//    init() {
//        super.init(frame:.zero)
//            rootFlexContainer.pin.height(100).left().right().top()
//    }
//
//    public func configure(viewModel:MovieSearchViewModel) {
//        moviePoster.kf.setImage(with: URL(string: viewModel.imageURLString))
//        titleLabel.text = viewModel.title
//        titleLabel.flex.markDirty()
//        directorLabel.text = viewModel.director
//        directorLabel.flex.markDirty()
//        releaseDateLabel.text = viewModel.year
//        releaseDateLabel.flex.markDirty()
//        contentDescriptionLabel.text = viewModel.contentInformation
//        contentDescriptionLabel.flex.markDirty()
//
//        setNeedsLayout()
//        layoutIfNeeded()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        rootFlexContainer.pin.height(100).left().right().top()
//        rootFlexContainer.flex.layout()
//
//        rootFlexContainer.flex.direction(.column).padding(10).define { (flex) in
//            flex.addItem().direction(.row).define({ (flex) in
//                flex.addItem(moviePoster).size(CGSize(width: 67, height: 100))
//
//                flex.addItem().direction(.column).grow(1).shrink(1).define({ (flex) in
//                    flex.addItem(titleLabel).marginLeft(10).grow(1)
//                    flex.addItem(directorLabel).marginLeft(10).grow(1)
//                    flex.addItem(releaseDateLabel).marginLeft(10).grow(1)
//                    flex.addItem(contentDescriptionLabel).marginLeft(10).grow(1)
//                })
//            })
//            flex.addItem().height(0.5).marginTop(10).grow(1).backgroundColor(.lightGray)
//        }
//    }
//}

import UIKit
import FlexLayout
import PinLayout

class IntroView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .gray
        rootFlexContainer.backgroundColor = .blue
        let imageView = UIImageView(image: UIImage(named: "flexlayout-logo"))
        
        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0
        
        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.\n\nFlexLayout syntax is concise and chainable."
        label.numberOfLines = 0
        
        let bottomLabel = UILabel()
        bottomLabel.text = "FlexLayout/yoga is incredibly fast, its even faster than manual layout."
        bottomLabel.numberOfLines = 0
        
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            flex.addItem().direction(.row).define { (flex) in
                flex.addItem(imageView).width(100).aspectRatio(of: imageView)
                
                flex.addItem().direction(.column).paddingLeft(12).grow(1).shrink(1).define { (flex) in
                    flex.addItem(segmentedControl).marginBottom(12).grow(1)
                    flex.addItem(label)
                }
            }
            
            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
            flex.addItem(bottomLabel).marginTop(12)
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        rootFlexContainer.pin.all()
        
        // Then let the flexbox container layout itself
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}
