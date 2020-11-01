//
//  ItemResponse.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias ItemsResponse = [ItemResponse]

struct ItemResponse: Codable {
    let resourceURI: String
    let name: String
}
