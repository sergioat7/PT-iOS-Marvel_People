//
//  CharacterListRouter.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class CharacterListRouter: BaseRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:CharacterListViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "CharacterListView", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "CharacterList") as? CharacterListViewController {
            let viewModel: CharacterListViewModelProtocol = CharacterListViewModel(dataManager: dataManager)
            controller.set(viewModel: viewModel)
            return controller
        }
        return CharacterListViewController()
    }
    
    private var dataManager: CharacterListDataManagerProtocol {
        return CharacterListDataManager(apiClient: apiClient)
    }
    
    private var apiClient: CharacterListApiClientProtocol {
        return CharacterListApiClient()
    }
    
    // MARK: - Initialization
    
    override init() {}
    
    // MARK: - Presentation Methods

    func push() {
        push(viewController: view)
    }
    
}

