//
//  CharacterDetailRouter.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class CharacterDetailRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:CharacterDetailViewController {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "CharacterDetailView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "CharacterDetail") as? CharacterDetailViewController {
            
            let viewModel: CharacterDetailViewModelProtocol = CharacterDetailViewModel(dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return CharacterDetailViewController()
    }
    
    private var dataManager: CharacterDetailDataManagerProtocol {
        return CharacterDetailDataManager(apiClient: apiClient,
                                          characterId: characterId)
    }
    
    private var apiClient: CharacterDetailApiClientProtocol {
        return CharacterDetailApiClient()
    }
    
    // MARK: - Initialization
    
    private let characterId: Int
    
    init (characterId: Int) {
        self.characterId = characterId
    }
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

