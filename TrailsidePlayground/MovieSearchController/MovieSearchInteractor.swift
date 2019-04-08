//
//  MovieSearchInteractor.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

protocol MovieSearchInteractorInput {
    func handle(_ request:MovieSearchModel.Function.Request)
}

///Class to handle api requests
class MovieSearchInteractor:MovieSearchInteractorInput {
    public var output:MovieSearchPresenterInput?
    
    func handle(_ request: MovieSearchModel.Function.Request) {
        switch request {
        case .SearchMovie(let searchTerm):
            findMovies(with: searchTerm)
        }
    }
    
    private func findMovies(with searchTerm:String) {
        HTTPWorker.instance.searchMovies(searchTerm: searchTerm) { [weak self] (responseObj) in
            if let responseObj = responseObj {
                do {
                    let decoder = JSONDecoder()
                    let movieSearchResult = try decoder.decode(MovieSearchResultDTO.self, from:responseObj)
                    self?.output?.process(.ProcessMovies(movieResultDTO: movieSearchResult))
                } catch {
                    self?.sendError(with: .CorruptedData)
                }
            } else {
                self?.sendError(with: .UnableToRetrieveData)
            }
        }
    }
    
    private func sendError(with error:MovieSearchModel.MovieSearchError) {
        output?.process(.SearchError(error:error))
    }
}
