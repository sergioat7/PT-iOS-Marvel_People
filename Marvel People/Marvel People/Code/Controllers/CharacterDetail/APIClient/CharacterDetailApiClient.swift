//
//  CharacterDetailApiClient.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterDetailApiClientProtocol {
    
    func getCharacter(characterId: Int)
    func getCharactersDataObserver() -> PublishSubject<CharactersDataResponse>
    func getErrorObserver() -> PublishSubject<ErrorResponse>
}

class CharacterDetailApiClient {
    
    // MARK: - Private variables
    
    private let charactersDataObserver: PublishSubject<CharactersDataResponse> = PublishSubject()
    private let errorObserver: PublishSubject<ErrorResponse> = PublishSubject()
}

// MARK: - CharacterDetailApiClientProtocol

extension CharacterDetailApiClient: CharacterDetailApiClientProtocol {
    
    func getCharacter(characterId: Int) {
        
        let request = GetCharacterRequest(characterId: characterId)
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
