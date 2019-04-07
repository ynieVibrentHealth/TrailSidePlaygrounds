//
//  MovieSearchRouter.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

enum MovieSearchDestination {
    case MovieDetails(movieViewModel:MovieSearchViewModel)
}

class MovieSearchRouter {
    private let view:MovieSearchView
    
    init(movieSearchView:MovieSearchView) {
        self.view = movieSearchView
    }
    
    public func navigate(to destination:MovieSearchDestination) {
        switch destination {
        case .MovieDetails(let movieViewModel):
            let detailsView = MovieDetailView()
            MovieDetailConfigurator.instance.configure(with: detailsView, movieViewModel: movieViewModel)
            view.navigationController?.pushViewController(detailsView, animated: true)
        }
    }
}
