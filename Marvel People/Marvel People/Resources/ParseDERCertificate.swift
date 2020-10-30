//
//  ParseDERCertificate.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import Alamofire

class ParseDERCertificate {
    
    /*
     We extract and bake the certificate data in code as base64 string
     to avoid someone replace the certificate file with another public key
     and makes the app vulnerable to Man in the Middle attacks
     */
    
    let base64Certificate = """
                            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
                            """

    public func getCertificates() -> [SecCertificate] {
        
        if let certificateData = Data(base64Encoded: base64Certificate, options: []),
            let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) {
            return [certificate]
        }
        return Bundle.main.af.certificates
    }
}
