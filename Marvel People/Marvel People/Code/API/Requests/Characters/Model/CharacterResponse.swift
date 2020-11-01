//
//  CharacterResponse.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

typealias CharactersResponse = [CharacterResponse]

struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailResponse
    let resourceURI: String
    let comics: ExtraDataListResponse
    let series: ExtraDataListResponse
    let stories: ExtraDataListResponse
    let events: ExtraDataListResponse
    let urls: UrlsResponse
}
