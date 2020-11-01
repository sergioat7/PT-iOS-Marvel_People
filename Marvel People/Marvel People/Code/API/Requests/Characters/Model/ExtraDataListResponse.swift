//
//  ExtraDataListResponse.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

struct ExtraDataListResponse: Codable {
    let available: Int
    let collectionURI: String
    let items: ItemsResponse
    let returned: Int
}
