//
//  CharacterDetailViewController.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

protocol CharacterDetailViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication VIEW_MODEL -> VIEW
     */
}

protocol CharacterDetailConfigurableViewProtocol: class {
    
    func set(viewModel: CharacterDetailViewModelProtocol)
}

class CharacterDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var viewModel: CharacterDetailViewModelProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
}

// MARK: - CharacterDetailViewProtocol

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
}

// MARK: - CharacterDetailViewProtocol

extension CharacterDetailViewController: CharacterDetailConfigurableViewProtocol {
    
    func set(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
    }
}
