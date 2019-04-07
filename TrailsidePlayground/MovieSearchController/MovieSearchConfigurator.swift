//
//  MovieSearchConfigurator.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

class MovieSearchConfigurator {
    static func configure(view:MovieSearchView) {
        let interactor = MovieSearchInteractor()
        let presenter = MovieSearchPresenter()
        let router = MovieSearchRouter(movieSearchView: view)
        
        interactor.output = presenter
        presenter.output = view
        view.output = interactor
        view.router = router
    }
}
