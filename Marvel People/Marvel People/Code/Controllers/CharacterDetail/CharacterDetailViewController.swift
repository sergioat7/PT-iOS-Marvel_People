//
//  CharacterDetailViewController.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol CharacterDetailViewProtocol: BaseViewProtocol {
}

protocol CharacterDetailConfigurableViewProtocol: class {
    
    func set(viewModel: CharacterDetailViewModelProtocol)
}

class CharacterDetailViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel: CharacterDetailViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    
    private func setupBindings() {
        
        viewModel?
            .getLoadingObserver()
            .bind(to: aiLoading.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel?
            .getErrorObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorResponse in
                
                self?.showError(message: errorResponse.message,
                                handler: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel?
            .getCharacterObserver()
            .subscribe(onNext: { [weak self] characterResponse in
                self?.setCharacterData(characterResponse: characterResponse)
                
            })
            .disposed(by: disposeBag)
    }
    
    private func setCharacterData(characterResponse: CharacterResponse) {
        
        if let imageUrl = URL(string: characterResponse.thumbnail.getThumbnail()) {

            ivCharacter.kf.indicatorType = .activity
            ivCharacter.kf.setImage(with: imageUrl)
        } else {
            ivCharacter.image = nil
        }
        
        lbName.attributedText = NSAttributedString(string: characterResponse.name,
                                                   attributes: [.font : UIFont.bold26,
                                                                .foregroundColor: UIColor.black])
        lbDescription.attributedText = NSAttributedString(string: characterResponse.description,
                                                          attributes: [.font : UIFont.regular17,
                                                                       .foregroundColor: UIColor.black])
    }
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
