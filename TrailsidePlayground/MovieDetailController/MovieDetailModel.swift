//
//  MovieDetailModel.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

struct MovieDetailModel {
    struct Function {
        enum Request {
            case MovieDetails(movieId:String)
            case SaveFavorite(movie:MovieSearchViewModel)
        }
        
        enum Response {
            case MovieError(error:MovieDetailError)
            case ProcessMovieDetails(movieResultDTO:MovieSearchDTO)
            case FavoriteSaved(movie:MovieSearchViewModel)
        }
        
        enum State {
            case Error(errorString:String)
            case MovieDetails(movieDetails:MovieSearchViewModel)
            case SaveSuccess(movie:MovieSearchViewModel)
        }
    }
    
    enum MovieDetailError {
        case UnableToRetrieve
        case CorruptedData
        case MissingData
    }
}
