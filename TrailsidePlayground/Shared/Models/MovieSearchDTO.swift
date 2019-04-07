//
//  MovieSearchDTO.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

struct MovieSearchResultDTO:Codable {
    public let results:[MovieSearchDTO]
}

struct MovieSearchDTO:Codable {
    public let trackName:String?
    public let trackId:Int?
    public let artworkUrl100:String?
    public let primaryGenreName:String?
    public let contentAdvisoryRating:String?
    public let shortDescription:String?
    public let longDescription:String?
    public let trackTimeMillis:Double?
    public let artistName:String?
    public let releaseDate:String?
    public let collectionName:String?
    public let trackPrice:Double?
    public let trackRentalPrice:Double?
    public let trackHdPrice:Double?
    public let trackHdRentalPrice:Double?
}
