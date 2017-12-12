//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

class MovieCellViewModel{
    
    private var movie:Movie!
    
    var posterURL:URL?
    var movieTitle:String!
    var releaseDate:String!
    var overview:String!
    
    init(_ movie:Movie){
        self.movie = movie
        setProperties()
    }
    
    func setProperties(){
        if let path = movie.posterPath{
            posterURL = URL(string: Constants.PosterImageBaseURL + path)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate){
            dateFormatter.dateFormat = "yyyy"
            releaseDate = "(\(dateFormatter.string(from: date)))"
        }
        
        
        movieTitle = movie.title
        overview = movie.overview
    }
    
}
