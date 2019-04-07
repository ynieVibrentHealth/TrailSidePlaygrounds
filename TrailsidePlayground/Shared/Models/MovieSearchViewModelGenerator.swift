//
//  MovieSearchViewModelGenerator.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

class MovieSearchViewModelGenerator {
    static let instance:MovieSearchViewModelGenerator = MovieSearchViewModelGenerator()
    private init(){}
    
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
    
    public func generateMovieViewModel(with movieDTO:MovieSearchDTO) -> MovieSearchViewModel?{
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
            isFavorite: false, rentHD: rentHDPrice(from: movieDTO), rentSD: rentSDPrice(from: movieDTO), buyHD: buyHDPrice(from: movieDTO), buySD: buySDPrice(from: movieDTO))
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
    
    private func rentHDPrice(from movieDTO:MovieSearchDTO) -> String {
        if let price = movieDTO.trackHdRentalPrice {
            let amount = String(format: "$%.02f", price)
            return amount
        } else {
            return "Rent HD"
        }
    }
    
    private func rentSDPrice(from movieDTO:MovieSearchDTO) -> String {
        if let price = movieDTO.trackRentalPrice {
            let amount = String(format: "$%.02f", price)
            return amount
        } else {
            return "Rent"
        }
    }
    
    private func buyHDPrice(from movieDTO:MovieSearchDTO) -> String {
        if let price = movieDTO.trackHdPrice {
            let amount = String(format: "$%.02f", price)
            return amount
        } else {
            return "Buy HD"
        }
    }
    
    private func buySDPrice(from movieDTO:MovieSearchDTO) -> String {
        if let price = movieDTO.trackPrice {
            let amount = String(format: "$%.02f", price)
            return amount
        } else {
            return "Buy"
        }
    }
}
