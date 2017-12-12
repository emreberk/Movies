//
//  StorageProtocol.swift
//  Movies
//
//  Created by Emre Berk on 11.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

protocol StorageProtocol{
    func addNewQuery(_ query:String)
    func getLastQueries() -> [String]
}

