//
//  ServiceError.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

enum ServiceError:Error{
    case parseFailed
    case requestFailed
    case unknown
    case service(code:Int, message:String)
}
