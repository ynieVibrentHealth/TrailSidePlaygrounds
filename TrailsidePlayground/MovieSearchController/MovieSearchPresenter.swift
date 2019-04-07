//
//  MovieSearchPresenter.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

protocol MovieSearchPresenterInput {
    func process(_ response:MovieSearchModel.Function.Response)
}

class MovieSearchPresenter:MovieSearchPresenterInput {
    public var output:MovieSearchViewInput?
    
    func process(_ response: MovieSearchModel.Function.Response) {
        switch response {
        case .SearchError(let error):
            self.handle(error)
        case .ProcessMovies(let movieResultDTO):
            generateViewModels(with: movieResultDTO)
        }
    }
    
    private func handle(_ error:MovieSearchModel.MovieSearchError) {
        switch error {
        case .CorruptedData:
            output?.display(.Error(errorString: "We were unable to process the data, please try again later!"))
        case .UnableToRetrieveData:
            output?.display(.Error(errorString: "We were unable to retrieve the data, please try again later!"))
        }
    }
    
    private func generateViewModels(with resultDTO:MovieSearchResultDTO) {
        let movieViewModels = resultDTO.results.map { (movieDTO) -> MovieSearchViewModel? in
            return MovieSearchViewModelGenerator.instance.generateMovieViewModel(with: movieDTO)
            }.compactMap{$0}
        output?.display(.MovieResults(movies: movieViewModels))
    }
}
