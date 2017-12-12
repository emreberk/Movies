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
}
