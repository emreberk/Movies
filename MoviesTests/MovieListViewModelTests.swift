//
//  MovieListViewModelTests.swift
//  MoviesTests
//
//  Created by Emre Berk on 13.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import XCTest
@testable import Movies

class MovieListViewModelTests:XCTestCase{
    
    var sut:MovieListViewModel!
    var service:ServiceMock!
    var response:SearchMovieResponse!
    
    override func setUp() {
        service = ServiceMock()
        response = SearchMovieResponse()
        response.movies = []
        sut = MovieListViewModel(searchMovieResponse: response, service: service)
        sut.searchText = "Hello"
    }
    
    func testLoadMoreWhenItsPossible(){
        let movieCount = sut.cellViewModels.count
        
        response.page = 1
        response.totalPages = 2
        response.movies = [Movie(),Movie()]
        sut.loadMore()
        
        XCTAssertGreaterThan(sut.cellViewModels.count, movieCount)
    }
    
    func testLoadMoreWhenAtLastPage(){
        let movieCount = sut.cellViewModels.count
        
        response.page = 2
        response.totalPages = 2
        response.movies = [Movie(),Movie()]
        sut.loadMore()
        
        XCTAssertEqual(sut.cellViewModels.count, movieCount)
    }
    
    func testLoadMoreFailed(){
        let movieCount = sut.cellViewModels.count
        
        response.page = 1
        response.totalPages = 2
        response.movies = [Movie(),Movie()]
        service.shouldSuccess = false
        sut.loadMore()
        
        XCTAssertEqual(sut.cellViewModels.count, movieCount)
    }

    
    override func tearDown() {
        sut = nil
    }
}
