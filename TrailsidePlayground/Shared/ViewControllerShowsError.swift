//
//  ViewControllerShowsError.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit


public protocol ViewControllerShowsError {
    func showError(with message:String)
}

public extension ViewControllerShowsError where Self:UIViewController {
    func showError(with message:String) {
        showErrorLabel(with: message, textColor: .white, backgroundColor: .lightGray)
    }
    
    private func showErrorLabel(with errorText:String, textColor:UIColor, backgroundColor:UIColor) {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 0)
        self.view.addSubview(label)
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        animateError(with: label, and:errorText)
    }
    
    private func animateError(with label:UILabel, and errorText:String) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let _self = self else {return}
            label.text = errorText
            let expectedHeight = _self.calculateLabelHeight(text: errorText, width: _self.view.frame.size.width - 20, font: UIFont.systemFont(ofSize: 14))
            label.frame = CGRect(x: 0, y: 3, width: _self.view.frame.size.width, height: expectedHeight + 6)
        }) { (finished) in
            if finished {
                Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
                    UIView.animate(withDuration: 0.3, animations: {
                        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
                    }, completion: { (finished) in
                        if finished {
                            label.removeFromSuperview()
                        }
                    })
                }
            }
        }
    }
    
    private func calculateLabelHeight(text:String, width:CGFloat, font:UIFont) -> CGFloat{
        let constrainedSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSAttributedString.Key.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height)
    }
}
