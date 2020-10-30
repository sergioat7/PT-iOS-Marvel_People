//
//  ThumbnailResponse.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import Foundation

struct ThumbnailResponse: Codable {
    let path: String
    let ext: String
    
    private enum CodingKeys: String, CodingKey {
        case ext = "extension"
        case path
    }
    
    func getThumbnail() -> String {
        return "\(path).\(ext)"
    }
}
