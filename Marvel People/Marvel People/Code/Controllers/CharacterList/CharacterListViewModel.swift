//
//  CharacterListViewModel.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift

protocol CharacterListViewModelProtocol: class {
    
    func viewDidLoad()
    func getCharacterCellViewModelsObserver() -> BehaviorSubject<[CharacterCellViewModel]>
    func getCharacterCellViewModelsObserverValue() -> [CharacterCellViewModel]
    func getCharacters()
}

class CharacterListViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:CharacterListViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: CharacterListDataManagerProtocol
    private let characterCellViewModelsObserver: BehaviorSubject<[CharacterCellViewModel]> = BehaviorSubject(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(view:CharacterListViewProtocol,
         dataManager: CharacterListDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    
    func viewDidLoad() {
        
        getCharacters()
        
        dataManager
            .getCharactersObserver()
            .subscribe(onNext: { [weak self] charactersResponse in
                
                guard let strongSelf = self else { return }
                var currentValue = strongSelf.getCharacterCellViewModelsObserverValue()
                let newValues = charactersResponse.map({ CharacterCellViewModel(character: $0) })
                currentValue.append(contentsOf: newValues)
                strongSelf.characterCellViewModelsObserver.onNext(currentValue)
            })
            .disposed(by: disposeBag)
    }
    
    func getCharacterCellViewModelsObserver() -> BehaviorSubject<[CharacterCellViewModel]> {
        return characterCellViewModelsObserver
    }
    
    func getCharacterCellViewModelsObserverValue() -> [CharacterCellViewModel] {
        
        do {
            return try characterCellViewModelsObserver.value()
        } catch {
            return []
        }
    }
    
    func getCharacters() {
        dataManager.getCharacters(search: nil)
    }
}

