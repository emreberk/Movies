//
//  ServiceErrorResponse.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper

class ServiceErrorResponse:Mappable{
    
    var errors:[String]!
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        errors  <- map["errors"]
    }
}
