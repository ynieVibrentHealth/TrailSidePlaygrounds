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
        }
        
        enum Response {
            case MovieError(error:MovieDetailError)
            case ProcessMovieDetails(movieResultDTO:MovieSearchDTO)
        }
        
        enum State {
            case Error(errorString:String)
            case MovieDetails(movieDetails:MovieSearchViewModel)
        }
    }
    
    enum MovieDetailError {
        case UnableToRetrieve
        case CorruptedData
        case MissingData
    }
}
