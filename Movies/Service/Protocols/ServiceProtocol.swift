//
//  ServiceProtocol.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

protocol ServiceProtocol{
    var baseURL: URL { set get }
    var defaultParameters: [String:Any] { set get }
}

extension ServiceProtocol{
    func request<T:Mappable>(_ endpoint: EndpointProtocol,
                             _ completion:@escaping (_ item:T?, _ error:ServiceError?) -> Void){
        
        var params = endpoint.parameters
        for (key,value) in defaultParameters{
            params[key] = value
        }
        
        let endpointURL = baseURL.appendingPathComponent(endpoint.path)
        
        Alamofire.request(endpointURL,
                          method: endpoint.method,
                          parameters: params,
                          headers: nil)
            .responseJSON {
                response in
                if response.result.isSuccess{
                    if response.response?.statusCode == 200 {
                        guard let value = response.result.value,
                            let item = Mapper<T>().map(JSONObject:value) else{
                                completion(nil, .parseFailed)
                                return
                        }
                        completion(item,nil)
                    }else{
                        guard let value = response.result.value,
                            let statusCode = response.response?.statusCode,
                            let error = Mapper<ServiceErrorResponse>().map(JSONObject:value),
                            let errors = error.errors,
                            errors.count > 0 else{
                                completion(nil, .unknown)
                                return
                        }
                        
                        completion(nil,.service(code:statusCode, message:errors[0]))
                    }
                }else{
                    completion(nil, .requestFailed)
                }
        }
    }
}
