//
//  MovieDetailButtonView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailButtonView:UIView {
    private var buttonPressAction:(() -> Void)?
    private let disposeBag:DisposeBag = DisposeBag()
    private var width:CGFloat?
    
    public lazy var button:UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rx.tap.subscribe(onNext: { () in
            self.buttonPressAction?()
        }).disposed(by:self.disposeBag)
        self.addSubview(button)
        return button
    }()
    
    public func configure(buttonTitle:String, width:CGFloat?, buttonAction:@escaping (() -> Void)) {
        button.setTitle(buttonTitle, for: .normal)
        self.buttonPressAction = buttonAction
        self.width = width
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    public func disableButton() {
        button.backgroundColor = UIColor.darkGray
        button.isUserInteractionEnabled = false
    }
    
    override func updateConstraints() {
        button.snp.updateConstraints { (make) in
            if let width = width {
                make.width.equalTo(width)
            }
            make.leading.trailing.equalTo(self).inset(20).priority(999)
            make.top.bottom.equalTo(self).inset(15).priority(999)
        }
        
        super.updateConstraints()
    }
}
