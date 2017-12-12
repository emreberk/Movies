//
//  Movie.swift
//  Movies
//
//  Created by Emre Berk on 10.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie:Mappable{
    
    var title:String!
    var overview:String!
    var releaseDate:String!
    
    var posterPath:String?
    var posterURL:URL?{
        guard let path = posterPath else { return nil }
        return URL(string:"https://image.tmdb.org/t/p/w92"+path)
    }
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        title         <- map["title"]
        posterPath    <- map["poster_path"]
        overview      <- map["overview"]
        releaseDate   <- map["release_date"]
    }
    
}
