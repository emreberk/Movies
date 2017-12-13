//
//  UserDefaultsMock.swift
//  MoviesTests
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
@testable import Movies

class UserDefaultsMock:UserDefaultsProtocol{
    
    var values = [String:Any?]()
    
    func set(_ value: Any?, forKey: String) {
        values[forKey] = value
    }
    
    func object(forKey: String) -> Any? {
        if let value = values[forKey] { return value }
        return nil
    }
}
