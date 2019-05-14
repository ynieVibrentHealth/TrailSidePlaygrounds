//
//  MovieDetailFlexView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 5/13/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

class MovieDetailFlexView:UIViewController {
    public var viewModel:MovieSearchViewModel?
    
    fileprivate lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.view.addSubview(view)
        return view
    }()
    
    fileprivate lazy var movieContentFlexView:IntroView = {
        let flexView = IntroView()
        return flexView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        edgesForExtendedLayout = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let viewModel = self.viewModel {
//            movieContentFlexView.configure(viewModel: viewModel)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        containerView.flex.addItem(movieContentFlexView)
//        containerView.flex.padding(20).define { (flex) in
//            flex.addItem(self.movieContentFlexView)
//        }
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        containerView.pin.all()
        containerView.flex.layout()
    }
}
