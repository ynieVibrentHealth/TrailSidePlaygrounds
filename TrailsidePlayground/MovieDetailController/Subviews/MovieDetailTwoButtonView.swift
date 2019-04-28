//
//  MovieDetailTwoButtonView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MovieDetailTwoButtonView:UIView {
    fileprivate lazy var stackContainer:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        self.addSubview(stackView)
        return stackView
    }()
    
    fileprivate lazy var leftButtonView:MovieDetailButtonView = MovieDetailButtonView()
    fileprivate lazy var rightButtonView:MovieDetailButtonView = MovieDetailButtonView()
    
    fileprivate lazy var dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        self.addSubview(view)
        return view
    }()
    
    public func configure(leftButtonTitle:String,
                          rightButtonTitle:String,
                          leftButtonAction:@escaping (() -> Void),
                          rightButtonAction:@escaping (() -> Void)) {
        let buttonWidth = UIScreen.main.bounds.width/2 - CGFloat(40)
        leftButtonView.configure(buttonTitle: leftButtonTitle, width: buttonWidth, buttonAction: leftButtonAction)
        stackContainer.addArrangedSubview(leftButtonView)
        rightButtonView.configure(buttonTitle: rightButtonTitle, width: buttonWidth, buttonAction: rightButtonAction)
        stackContainer.addArrangedSubview(rightButtonView)
        setNeedsUpdateConstraints()
        updateFocusIfNeeded()
    }
    
    override func updateConstraints() {
        stackContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(self).priority(999)
        }
        
        dividerLine.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(self).inset(15).priority(999)
            make.bottom.equalTo(self)
            make.height.equalTo(0.5).priority(999)
        }
        super.updateConstraints()
    }
}
