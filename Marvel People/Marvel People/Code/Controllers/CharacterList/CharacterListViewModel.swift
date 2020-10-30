//
//  CharacterListViewModel.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol CharacterListViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class CharacterListViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:CharacterListViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: CharacterListDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:CharacterListViewProtocol,
         dataManager: CharacterListDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    
}

