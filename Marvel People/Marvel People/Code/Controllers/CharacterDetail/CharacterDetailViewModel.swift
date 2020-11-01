//
//  CharacterDetailViewModel.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol CharacterDetailViewModelProtocol: class {
    /**
     * Add here your methods for communication VIEW -> VIEW_MODEL
     */
}

class CharacterDetailViewModel: BaseViewModel {
    
    // MARK: - Public variables
    
    weak var view:CharacterDetailViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: CharacterDetailDataManagerProtocol
    
    // MARK: - Initialization
    
    init(view:CharacterDetailViewProtocol,
         dataManager: CharacterDetailDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

extension CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
}

