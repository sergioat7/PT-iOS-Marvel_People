//
//  CharacterDetailDataManager.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterDetailDataManagerProtocol: class {
    
    func getCharacter()
    func getCharacterObserver() -> PublishSubject<CharacterResponse>
    func getErrorObserver() -> PublishSubject<ErrorResponse>
}

class CharacterDetailDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: CharacterDetailApiClientProtocol
    private let characterId: Int
    private let characterObserver: PublishSubject<CharacterResponse> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: CharacterDetailApiClientProtocol,
         characterId: Int) {
        self.apiClient = apiClient
        self.characterId = characterId
    }
}

extension CharacterDetailDataManager: CharacterDetailDataManagerProtocol {
    
    func getCharacter() {
        
        apiClient.getCharacter(characterId: characterId)
        
        apiClient
            .getCharactersDataObserver()
            .subscribe(onNext: { [weak self] charactersDataResponse in
                
                if let character = charactersDataResponse.data.results.first {
                    self?.characterObserver.onNext(character)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getCharacterObserver() -> PublishSubject<CharacterResponse> {
        return characterObserver
    }
    
    func getErrorObserver() -> PublishSubject<ErrorResponse> {
        return apiClient.getErrorObserver()
    }
}

