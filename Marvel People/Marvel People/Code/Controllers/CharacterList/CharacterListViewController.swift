//
//  CharacterListViewController.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 30/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    @IBOutlet weak var tvCharacters: UITableView!
    
    // MARK: - Private properties
    
    private var viewModel:CharacterListViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MARVEL_CHARACTERS".localized()
        registerNib()
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func registerNib() {
        
        tvCharacters.register(UINib(nibName: "CharacterTableViewCell",
                                    bundle: nil),
                              forCellReuseIdentifier: Constants.cellName)
    }
    
    private func setupBindings() {
        
        tvCharacters
            .rx
            .willDisplayCell
            .subscribe(onNext: ({ [weak self] (cell,indexPath) in
                
                guard let strongSelf = self else { return }
                let characterCellViewModelsCount = strongSelf.viewModel?.getCharacterCellViewModelsObserverValue().count ?? 0
                if indexPath.item == (characterCellViewModelsCount - 1) {
                    //TODO load more items
                }
            }))
            .disposed(by: disposeBag)
        
        tvCharacters
            .rx
            .itemSelected
            .subscribe(onNext:{ [weak self] indexPath in
                
                guard let strongSelf = self else { return }
                let characterCellViewModels = strongSelf.viewModel?.getCharacterCellViewModelsObserverValue()
                if let characterId = characterCellViewModels?[indexPath.row].id {
                    //TODO go to character detail
                    print(characterId)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel?
            .getCharacterCellViewModelsObserver()
            .bind(to: tvCharacters.rx.items(cellIdentifier: Constants.cellName, cellType: CharacterTableViewCell.self)) { _,character,cell in
                cell.characterCellViewModel = character
            }
            .disposed(by: disposeBag)
    }
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
