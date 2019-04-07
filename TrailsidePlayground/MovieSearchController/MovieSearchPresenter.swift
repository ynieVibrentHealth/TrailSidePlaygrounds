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
    
    func process(_ response: MovieSearchModel.Function.Response) {
        
    }
}
