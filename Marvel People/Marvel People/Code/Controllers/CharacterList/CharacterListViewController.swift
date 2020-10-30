//
//  CharacterListViewController.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol CharacterListViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
    
}

protocol CharacterListConfigurableViewProtocol: class {
    
    func set(viewModel: CharacterListViewModelProtocol)
    
}

class CharacterListViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel:CharacterListViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MARVEL_CHARACTERS".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - CharacterListViewProtocol

extension CharacterListViewController:  CharacterListViewProtocol {
    
}

// MARK: - CharacterListViewProtocol

extension CharacterListViewController:  CharacterListConfigurableViewProtocol {
    
    func set(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
    }
    
}
