//
//  MovieService.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

class MovieService:ServiceProtocol{
    var baseURL:URL = URL(string: "https://api.themoviedb.org/")!
    var defaultParameters:[String : Any] = ["api_key":"2696829a81b1b5827d515ff121700838"]
}
