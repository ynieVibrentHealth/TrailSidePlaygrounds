//
//  MovieDetailInteractor.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInput {
    func handle(_ request:MovieDetailModel.Function.Request)
}

class MovieDetailInteractor: MovieDetailInteractorInput {
    public var output:MovieDetailPresenterInput?
    
    func handle(_ request: MovieDetailModel.Function.Request) {
        switch request {
        case .MovieDetails(let movieId):
            loadMovieDetails(with: movieId)
        case .SaveFavorite(let movie):
            saveFavorite(movie: movie)
        }
    }
    
    private func loadMovieDetails(with movieId:String) {
        HTTPWorker.instance.searchMovieDetails(movieId: movieId) { [weak self] (response) in
            if let responseData = response{
                do {
                    let decoder = JSONDecoder()
                    let movieSearchResult = try decoder.decode(MovieSearchResultDTO.self, from:responseData)
                    if let movieDetailDTO = movieSearchResult.results.first {
                        self?.output?.process(.ProcessMovieDetails(movieResultDTO: movieDetailDTO))
                    } else {
                        self?.sendError(with: .MissingData)
                    }
                } catch {
                    self?.sendError(with: .CorruptedData)
                }
            } else {
                self?.sendError(with: .UnableToRetrieve)
            }
        }
    }
    
    private func saveFavorite(movie:MovieSearchViewModel) {
        FavoriteMovieCoreDataHelper.instance.saveFavoriteMovie(movieViewModel: movie) { (success) in
            if success {
                output?.process(.FavoriteSaved(movie: movie))
            }
        }
    }
    
    private func sendError(with error:MovieDetailModel.MovieDetailError) {
        
    }
}
