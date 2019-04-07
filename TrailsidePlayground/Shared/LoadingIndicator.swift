//
//  LoadingIndicator.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

class LoadingIndicator:UIView {
    fileprivate lazy var activityIndicator:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = UIActivityIndicatorView.Style.gray
        self.addSubview(activity)
        activity.snp.updateConstraints({ (make) in
            make.center.equalTo(self)
        })
        return activity
    }()
    
    public func loadActivity() {
        activityIndicator.startAnimating()
    }
}
