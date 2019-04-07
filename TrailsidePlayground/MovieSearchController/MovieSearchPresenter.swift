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
    
    private lazy var apiDateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    private lazy var releaseDateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
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
            return self.generateMovieViewModel(with: movieDTO)
            }.compactMap{$0}
        output?.display(.MovieResults(movies: movieViewModels))
    }
    
    private func generateMovieViewModel(with movieDTO:MovieSearchDTO) -> MovieSearchViewModel?{
         guard let trackName = movieDTO.trackName,
            let trackId = movieDTO.trackId,
            let artworkUrl60 = movieDTO.artworkUrl100,
            let artistName = movieDTO.artistName,
            let releaseDate = movieDTO.releaseDate else {return nil}
        
        var description:String = ""
        if let shortDescription = movieDTO.longDescription {
            description = shortDescription
        } else if let longDescription = movieDTO.shortDescription {
            description = longDescription
        }
        
        return MovieSearchViewModel(title: trackName,
                                    director: artistName,
                                    year: generateReleaseDate(from: releaseDate),
                                    description: description,
                                    imageURLString: artworkUrl60,
                                    trackId: "\(trackId)",
                                    contentInformation: generateContentInformation(from: movieDTO),
                                    isFavorite: false)
    }
    
    private func generateReleaseDate(from dtoDate:String) -> String{
        guard let releaseDate = self.apiDateFormatter.date(from: dtoDate) else {return ""}
        let releaseDateString = self.releaseDateFormatter.string(from: releaseDate)
        return "Released: \(releaseDateString)"
    }
    
    private func generateContentInformation(from movieDTO:MovieSearchDTO) -> String {
        var contentInformation:String = ""
        if let rating = movieDTO.contentAdvisoryRating {
            contentInformation += rating
        }
        
        if let runtimeMills = movieDTO.trackTimeMillis {
            let minutes = Int(runtimeMills/60000)
            if !contentInformation.isEmpty {
                contentInformation += ", "
            }
            contentInformation += "\(minutes) minutes"
        }
        
        return contentInformation
    }
}
