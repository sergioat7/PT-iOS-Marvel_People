//
//  APIClient.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation
import Alamofire
import SwifterSwift

public class APIClient {
    
    // MARK: - Private properties
    
    public static let shared = APIClient()
    
    // MARK: - Private properties
    
    private let session = Session(configuration: URLSessionConfiguration.default)
    private var baseEndpoint: String {
        return "https://gateway.marvel.com/v1/public"
    }
    private var defaultQueryParams: Parameters {
        return [
            "apikey" : "5ed58006f51feb029d1240da98b047c6",
            "ts" : "1",
            "hash" : "050b4ab4753325c5f5b3538c50e5c4e7"
        ]
    }
    
    // MARK: - Public functions
    
    func sendServer<T: APIRequest>(_ request: T,
                                   success: @escaping (T.Response) -> Void,
                                   failure: @escaping (ErrorResponse) -> Void) {
        
        let endpoint = URL(string: baseEndpoint)!
        let method = request.method
        
        var parameters: Parameters = defaultQueryParams
        parameters += request.queryParams
        
        let request = session.request(endpoint,
                                      method: method,
                                      parameters: parameters,
                                      encoding: URLEncoding(destination: .queryString)).validate()
        request.responseJSON { response in
            
            let statusCode = response.response?.statusCode ?? -1
            
            if statusCode < 400, let data = response.data {
                do {
                    
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    success(response)
                    return
                } catch {
                    self.mapErrorData(data: data, failure: failure)
                }
            } else if statusCode >= 400 && statusCode < 500, let data = response.data {
                self.mapErrorData(data: data, failure: failure)
            } else {
                
                let errorResponse = ErrorResponse(message: "ERROR_SERVER".localized())
                failure(errorResponse)
                return
            }
        }
    }
    
    // MARK: - Private functions
    
    private func mapErrorData(data: Data, failure: @escaping (ErrorResponse) -> Void) {
        
        do {
            
            let response = try JSONDecoder().decode(ErrorResponse.self, from: data)
            failure(response)
            return
        } catch {
            
            let error = ErrorResponse(message: "ERROR_SERVER".localized())
            failure(error)
            return
        }
    }
}

