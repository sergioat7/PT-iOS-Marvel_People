//
//  CharacterDetailViewModel.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterDetailViewModelProtocol: class {
    
    func viewDidLoad()
    func getLoadingObserver() -> PublishSubject<Bool>
    func getErrorObserver() -> PublishSubject<ErrorResponse>
    func getCharacterObserver() -> PublishSubject<CharacterResponse>
}

class CharacterDetailViewModel: BaseViewModel {
    
    // MARK: - Private variables
    
    private var dataManager: CharacterDetailDataManagerProtocol
    private let loadingObserver: PublishSubject<Bool> = PublishSubject()
    private let errorObserver: PublishSubject<ErrorResponse> = PublishSubject()
    private let characterObserver: PublishSubject<CharacterResponse> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(dataManager: CharacterDetailDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    func viewDidLoad() {
        
        loadingObserver.onNext(true)
        dataManager.getCharacter()
        
        dataManager
            .getCharacterObserver()
            .subscribe(onNext: { [weak self] characterResponse in
                
                guard let strongSelf = self else { return }
                strongSelf.characterObserver.onNext(characterResponse)
                strongSelf.loadingObserver.onNext(false)
            })
            .disposed(by: disposeBag)
        
        dataManager
            .getErrorObserver()
            .subscribe(onNext: { [weak self] errorResponse in
                
                guard let strongSelf = self else { return }
                strongSelf.loadingObserver.onNext(false)
                strongSelf.errorObserver.onNext(errorResponse)
            })
            .disposed(by: disposeBag)
    }
    
    func getLoadingObserver() -> PublishSubject<Bool> {
        return loadingObserver
    }
    
    func getErrorObserver() -> PublishSubject<ErrorResponse> {
        return errorObserver
    }
    
    func getCharacterObserver() -> PublishSubject<CharacterResponse> {
        return characterObserver
    }
}

