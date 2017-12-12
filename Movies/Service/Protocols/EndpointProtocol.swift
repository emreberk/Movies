//
//  ServiceProtocol.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import Alamofire

protocol EndpointProtocol{
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: [String:Any] { get }
}
