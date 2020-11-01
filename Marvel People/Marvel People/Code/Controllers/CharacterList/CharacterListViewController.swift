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
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    // MARK: - Private properties
    
    private var viewModel:CharacterListViewModelProtocol?
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MARVEL_CHARACTERS".localized()
        configViews()
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
    
    private func configViews() {
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tvCharacters.refreshControl = refreshControl
    }
    
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
                strongSelf.refreshControl.endRefreshing()
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
            .getLoadingObserver()
            .bind(to: aiLoading.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel?
            .getCharacterCellViewModelsObserver()
            .bind(to: tvCharacters.rx.items(cellIdentifier: Constants.cellName, cellType: CharacterTableViewCell.self)) { _,character,cell in
                cell.characterCellViewModel = character
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func reloadData() {
        
        viewModel?.reloadData()
        viewModel?.getCharacters()
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
