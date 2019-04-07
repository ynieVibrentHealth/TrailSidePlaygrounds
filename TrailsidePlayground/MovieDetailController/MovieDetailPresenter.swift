//
//  MovieDetailPresenter.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInput {
    func process(_ response: MovieDetailModel.Function.Response)
}

class MovieDetailPresenter: MovieDetailPresenterInput {
    public var output:MovieDetailViewInput?
    
    func process(_ response: MovieDetailModel.Function.Response) {
        switch response {
        case .ProcessMovieDetails(let movieResultDTO):
            generateMovieDetailsDTO(with: movieResultDTO)
        case .MovieError(let error):
            generateError(with: error)
        }
    }
    
    private func generateError(with error:MovieDetailModel.MovieDetailError) {
        
    }
    
    private func generateMovieDetailsDTO(with movieDTO:MovieSearchDTO) {
        if let movieDetailsViewModel = MovieSearchViewModelGenerator.instance.generateMovieViewModel(with: movieDTO) {
            output?.display(.MovieDetails(movieDetails: movieDetailsViewModel))
        } else {
            generateError(with: .MissingData)
        }
    }
}
