//
//  MovieSearchDTO.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

struct MovieSearchResultDTO:Codable {
    public var results:[MovieSearchDTO]
}

struct MovieSearchDTO:Codable {
    public var trackName:String?
    public var trackId:Int?
    public var artworkUrl100:String?
    public var primaryGenreName:String?
    public var contentAdvisoryRating:String?
    public var shortDescription:String?
    public var longDescription:String?
    public var trackTimeMillis:Double?
    public var artistName:String?
    public var releaseDate:String?
}
