//
//  UserDefaultsStorageTests.swift
//  MoviesTests
//
//  Created by Emre Berk on 11.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import XCTest
@testable import Movies

class UserDefaultsStorageTests:XCTestCase{
    
    var sut:UserDefaultsStorage!
    
    override func setUp() {
        sut = UserDefaultsStorage(UserDefaultsMock())
    }
    
    func testMaxQueriesLimit(){
        let given = ["11","10","9","8","7","6","5","4","3","2","1"]
        
        for item in given{
            sut.addNewQuery(item)
        }
        
        XCTAssertEqual(sut.getLastQueries(), ["10","9","8","7","6","5","4","3","2","1"].reversed())
    }
    
    func testAddNewQuery(){
        sut.addNewQuery("Hello")
        
        XCTAssertEqual(sut.getLastQueries().count, 1)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    
    
}
