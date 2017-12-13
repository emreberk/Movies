//
//  MockService.swift
//  MoviesTests
//
//  Created by Emre Berk on 13.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import Movies

class ServiceMock:ServiceProtocol{
    var baseURL: URL = URL(string:"www.google.com")!
    var defaultParameters: [String : Any] = [:]
    
    var shouldSuccess = true
    
    func request<T>(_ endpoint: EndpointProtocol,
                    _ completion: @escaping (T?, ServiceError?) -> Void) where T : Mappable {
        
        if !shouldSuccess{
            completion(nil, ServiceError.unknown)
            return
        }
        
        if let instance = T(JSONString: endpoint.sampleResponse){
            completion(instance, nil)
        }
        
    }
}
