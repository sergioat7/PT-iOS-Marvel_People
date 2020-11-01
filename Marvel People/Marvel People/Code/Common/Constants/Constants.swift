//
//  Constants.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import CryptoKit

struct Constants {

    // MARK: - Network constants
    
    static let host = "gateway.marvel.com"
    static let apiKeyQueryParam = "apikey"
    static let tsQueryParam = "ts"
    static let hashQueryParam = "hash"
    static let limitQueryParam = "limit"
    static let offsetQueryParam = "offset"
    static let nameStartsWithQueryParam = "nameStartsWith"
    static let publicKey = "5ed58006f51feb029d1240da98b047c6"
    static let privateKey = "659fd58aced58e8705daca11124bb52b8da3e47a"
    static let limit = 20
    
    static func md5(string: String) -> String {
        
        let computed = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
    
    // MARK: - Table view constants
    
    static let cellName = "CharacterCell"
}
