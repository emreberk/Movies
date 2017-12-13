//
//  MovieCellViewModelTests.swift
//  MoviesTests
//
//  Created by Emre Berk on 13.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import XCTest
@testable import Movies

class MovieCellViewModelTests:XCTestCase{
    
    func testInitWithValidDateMovie(){
        let given = "2010-10-10"
        
        let movie = Movie()
        movie.releaseDate = given
        let vm = MovieCellViewModel(movie)
        
        XCTAssertEqual(vm.releaseDate, "(2010)")
    }
    
    func testInitWithInvalidDateMovie(){
        let given = "20.01.2010"
        
        let movie = Movie()
        movie.releaseDate = given
        let vm = MovieCellViewModel(movie)
        
        XCTAssertEqual(vm.releaseDate, nil)
    }
    
    func testInitWithNilPosterPathMovie(){
        let movie = Movie()
        let vm = MovieCellViewModel(movie)
        
        XCTAssertEqual(vm.posterURL, nil)
    }
    
    func testInitWithValidPosterPathMovie(){
        let given = "/testtest.jpg"
        
        let movie = Movie()
        movie.posterPath = given
        let vm = MovieCellViewModel(movie)
        
        XCTAssertEqual(vm.posterURL, URL(string:"https://image.tmdb.org/t/p/w92"+given)!)
    }

}

