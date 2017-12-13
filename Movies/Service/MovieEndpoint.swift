//
//  MovieEndpoint.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import Alamofire

enum MovieEndpoint{
    case searchMovie(query:String, page:Int)
}

extension MovieEndpoint: EndpointProtocol{
    var baseURL: URL{
        return URL(string: "https://api.themoviedb.org/")!
    }
    
    var method: HTTPMethod{
        switch self {
        case .searchMovie(_,_):
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .searchMovie(_, _):
            return "3/search/movie"
        }
    }
    
    var parameters: [String:Any]{
        switch self {
        case .searchMovie(let query, let page):
            return ["query":query, "page":page]
        }
    }
    
    // FIXME: It can retrieve from a file. Shouldn't be here.
    var sampleResponse: String{
        switch self {
        case .searchMovie(_, _):
            return """
            {
            "page": 1,
            "total_results": 98,
            "total_pages": 5,
            "results": [
            {
            "vote_count": 2305,
            "id": 268,
            "video": false,
            "vote_average": 7,
            "title": "Batman",
            "popularity": 26.310799,
            "poster_path": "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg",
            "original_language": "en",
            "original_title": "Batman",
            "genre_ids": [
            14,
            28
            ],
            "backdrop_path": "/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg",
            "adult": false,
            "overview": "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.",
            "release_date": "1989-06-23"
            }
            ]
            }
            """
        }
    }
}
