//
//  CharacterListApiClient.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterListApiClientProtocol {
    
    func getCharacters(page: Int, search: String?)
    func getCharactersDataObserver() -> PublishSubject<CharactersDataResponse>
    func getErrorObserver() -> PublishSubject<ErrorResponse>
}

class CharacterListApiClient {
    
    // MARK: - Private variables
    
    private let charactersDataObserver: PublishSubject<CharactersDataResponse> = PublishSubject()
    private let errorObserver: PublishSubject<ErrorResponse> = PublishSubject()
}

// MARK: - CharacterListApiClientProtocol

extension CharacterListApiClient: CharacterListApiClientProtocol {
    
    func getCharacters(page: Int, search: String?) {
        
        let request = GetCharactersRequest(page: page,
                                           search: search)
        APIClient.shared.sendServer(request,
                                    success: { [weak self] charactersDataResponse in
                                        self?.charactersDataObserver.onNext(charactersDataResponse)
                                    }, failure: { [weak self] errorResponse in
                                        self?.errorObserver.onNext(errorResponse)
                                    })
    }
    
    func getCharactersDataObserver() -> PublishSubject<CharactersDataResponse> {
        return charactersDataObserver
    }
    
    func getErrorObserver() -> PublishSubject<ErrorResponse> {
        return errorObserver
    }
}
