//
//  UserDefaultsStorage.swift
//  Movies
//
//  Created by Emre Berk on 11.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol{
    func set(_ value: Any?, forKey: String)
    func object(forKey: String) -> Any?
}

extension UserDefaults: UserDefaultsProtocol{}

class UserDefaultsStorage: StorageProtocol{
    
    private struct Constant{
        static let UserDefaultKey = "AutoSuggestQueries"
        static let LastQueriesMaxLimit = 10
    }
    
    private let userDefaults:UserDefaultsProtocol!
    
    init(_ defaults:UserDefaultsProtocol = UserDefaults.standard){
        self.userDefaults = defaults
    }
    
    func addNewQuery(_ query: String) {
        var lastQueries = getLastQueries()
        let countDifference = lastQueries.count - Constant.LastQueriesMaxLimit
        if countDifference >= 0{
            lastQueries = Array(lastQueries.dropLast(countDifference+1))
        }
        lastQueries.insert(query, at: 0)
        userDefaults.set(lastQueries, forKey: Constant.UserDefaultKey)
    }
    
    func getLastQueries() -> [String] {
        guard let lastQueries = userDefaults.object(forKey: Constant.UserDefaultKey) as? [String] else{
            return []
        }
        return lastQueries
    }
}
