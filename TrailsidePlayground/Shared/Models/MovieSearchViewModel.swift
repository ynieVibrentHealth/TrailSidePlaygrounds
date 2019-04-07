//
//  MovieSearchViewModel.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

struct MovieSearchViewModel {
    let title:String
    let director:String
    let year:String
    let description:String
    let imageURLString:String
    let id:String
    let contentInformation:String
    let isFavorite:Bool
    let rentHD:String
    let rentSD:String
    let buyHD:String
    let buySD:String
    init(title:String, director:String, year:String, description:String, imageURLString:String, trackId:String, contentInformation:String, isFavorite:Bool, rentHD:String, rentSD:String, buyHD:String, buySD:String) {
        self.title = title
        self.director = director
        self.year = year
        self.description = description
        self.imageURLString = imageURLString
        self.isFavorite = isFavorite
        self.id = trackId
        self.contentInformation = contentInformation
        self.rentHD = rentHD
        self.rentSD = rentSD
        self.buyHD = buyHD
        self.buySD = buySD
    }
}
