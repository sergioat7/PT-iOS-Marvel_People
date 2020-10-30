//
//  GetCharactersRequest.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire

class GetCharactersRequest: APIRequest {
    
    public typealias Response = CharactersDataResponse
    
    public typealias Error = ErrorResponse
    
    public var resourceName: String {
        return "/characters"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    public var resourcePath: String {
        return ""
    }
    
    public var queryParams: Parameters
    
    public init(search: String?) {
        
        queryParams = [:]
        if let search = search {
            queryParams[Constants.nameStartsWithQueryParam] = search
        }
    }
}
