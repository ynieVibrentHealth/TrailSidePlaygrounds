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
            
        }
        
        enum State {
            
        }
    }
    
    enum MovieSearchError:Error {
        case UnableToFindMovie
    }
}
