//
//  SearchViewModel.swift
//  MoviesTests
//
//  Created by Emre Berk on 13.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import XCTest
@testable import Movies

class SearchViewModelTests:XCTestCase{
    
    var sut:SearchViewModel!
    var storage:UserDefaultsStorage!
    var service:ServiceMock!
    
    override func setUp() {
        storage = UserDefaultsStorage(UserDefaultsMock())
        service = ServiceMock()
        sut = SearchViewModel(storage, service)
    }
    
    func testFailedSearch(){
        let given = "Hello"
        
        service.shouldSuccess = false
        sut.searchMovies(for: given)
        
        XCTAssertEqual(sut.lastQueries, [])
    }
    
    func testSuccessfullSearch(){
        let given = "Hello"
        
        service.shouldSuccess = true
        sut.searchMovies(for: given)
        
        XCTAssertEqual(sut.lastQueries, [given])
    }
    
    override func tearDown() {
        sut = nil
    }
}
