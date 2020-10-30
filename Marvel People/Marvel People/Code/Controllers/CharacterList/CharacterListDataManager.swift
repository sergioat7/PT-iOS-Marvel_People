//
//  CharacterListDataManager.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol CharacterListDataManagerProtocol: class {
    /**
     * Add here your methods for communication VIEW_MODEL -> DATA_MANAGER
     */
}

class CharacterListDataManager: BaseDataManager {
    
    // MARK: - Public variables
    
    private let apiClient: CharacterListApiClientProtocol
    
    // MARK: - Private variables
    
    // MARK: - Initialization
    
    init(apiClient: CharacterListApiClientProtocol) {
        self.apiClient = apiClient
    }
}

extension CharacterListDataManager: CharacterListDataManagerProtocol {
    
}

