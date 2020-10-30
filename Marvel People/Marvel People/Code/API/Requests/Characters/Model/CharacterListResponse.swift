//
//  CharacterListResponse.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

struct CharacterListResponse: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: CharactersResponse
}
