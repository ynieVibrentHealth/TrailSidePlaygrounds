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

class MovieSearchInteractor:MovieSearchInteractorInput {
    public var output:MovieSearchPresenterInput?
    
    func handle(_ request: MovieSearchModel.Function.Request) {
        
    }
}
