//
//  SearchMovieResponse.swift
//  Movies
//
//  Created by Emre Berk on 10.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchMovieResponse:Mappable{
    
    var page:Int!
    var totalResults:Int!
    var totalPages:Int!
    var movies:[Movie]!
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        page         <- map["page"]
        totalResults <- map["totalResults"]
        totalPages   <- map["totalPages"]
        movies       <- map["results"]
    }
}
