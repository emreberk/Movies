//
//  RealmStorage.swift
//  Movies
//
//  Created by Emre Berk on 11.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

class UserDefaultsStorage: StorageProtocol{
    
    private struct Constant{
        static let UserDefaultKey = "AutoSuggestQueries"
    }
    
    private let userDefaults = UserDefaults.standard
    
    func addNewQuery(_ query: String) {
        var lastQueries = getLastQueries()
        lastQueries.append(query)
        userDefaults.set(lastQueries, forKey: Constant.UserDefaultKey)
    }
    
    func getLastQueries() -> [String] {
        guard let lastQueries = userDefaults.object(forKey: Constant.UserDefaultKey) as? [String] else{
            return []
        }
        return lastQueries
    }
}
