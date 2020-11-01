//
//  CharacterDetailDataManager.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol CharacterDetailDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class CharacterDetailDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: CharacterDetailApiClientProtocol
    private let characterId: Int
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: CharacterDetailApiClientProtocol,
         characterId: Int) {
        self.apiClient = apiClient
        self.characterId = characterId
    }
}

extension CharacterDetailDataManager: CharacterDetailDataManagerProtocol {
    
}

