//
//  MovieSearchModel.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

struct MovieSearchModel {
    
    struct Function {
        
        enum Request {
            case SearchMovie(searchTerm:String)
        }
        
        enum Response {
            case SearchError(error:MovieSearchError)
            case ProcessMovies(movieResultDTO:MovieSearchResultDTO)
        }
        
        enum State {
            case MovieResults(movies:[MovieSearchViewModel])
            case Error(errorString:String)
        }
    }
    
    enum MovieSearchError:Error {
        case NetworkRequest
        case CorruptedData
        case UnableToRetrieveData
        case UnableToSetupURL
    }
}
