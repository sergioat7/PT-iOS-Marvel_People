//
//  UrlResponse.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias UrlsResponse = [UrlResponse]

struct UrlResponse: Codable {
    let type: String
    let url: String
}
