//
//  CharacterListDataManager.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterListDataManagerProtocol: class {
    
    func getCharacters(search: String?)
    func resetPage()
    func getCharactersObserver() -> PublishSubject<CharactersResponse>
    func getErrorObserver() -> PublishSubject<ErrorResponse>
}

class CharacterListDataManager: BaseDataManager {
    
    // MARK: - Private variables
    
    private let apiClient: CharacterListApiClientProtocol
    private let charactersObserver: PublishSubject<CharactersResponse> = PublishSubject()
    private let disposeBag = DisposeBag()
    private var page: Int = 1
    
    // MARK: - Initialization
    
    init(apiClient: CharacterListApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension CharacterListDataManager: CharacterListDataManagerProtocol {
    
    func getCharacters(search: String?) {
        
        apiClient.getCharacters(page: page,
                                search: search)
        
        apiClient
            .getCharactersDataObserver()
            .subscribe(onNext: { [weak self] charactersDataResponse in
                
                guard let strongSelf = self else { return }
                strongSelf.page += 1
                strongSelf.charactersObserver.onNext(charactersDataResponse.data.results)
            })
            .disposed(by: disposeBag)
    }
    
    func resetPage() {
        page = 1
    }
    
    func getCharactersObserver() -> PublishSubject<CharactersResponse> {
        return charactersObserver
    }
    
    func getErrorObserver() -> PublishSubject<ErrorResponse> {
        return apiClient.getErrorObserver()
    }
}

