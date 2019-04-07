//
//  MovieDetailConfigurator.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

class MovieDetailConfigurator {
    static let instance:MovieDetailConfigurator = MovieDetailConfigurator()
    private init(){}
    
    public func configure(with view:MovieDetailView, movieViewModel:MovieSearchViewModel) {
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        
        view.output = interactor
        interactor.output = presenter
        presenter.output = view
        
        view.movieDetailsViewModel = movieViewModel
    }
}
