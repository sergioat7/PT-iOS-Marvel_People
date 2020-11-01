//
//  CharacterDetailViewModelTests.swift
//  Marvel PeopleTests
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Marvel_People

class CharacterDetailViewModelTests: XCTestCase {
    
    var sutRight: CharacterDetailViewModelProtocol!
    var sutWrong: CharacterDetailViewModelProtocol!
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        
        super.setUp()
        sutRight = CharacterDetailViewModel(dataManager: CharacterDetailDataManager(apiClient: CharacterDetailApiClient(),
                                                                                    characterId: 1009610))
        sutWrong = CharacterDetailViewModel(dataManager: CharacterDetailDataManager(apiClient: CharacterDetailApiClient(),
                                                                                    characterId: 0))
    }

    override func tearDownWithError() throws {
        
        sutRight = nil
        sutWrong = nil
        super.tearDown()
    }
    
    func testLoading() {
        
        var isLoading: Bool?
        let promise = expectation(description: "")
        
        sutRight.viewDidLoad()
        sutRight
            .getLoadingObserver()
            .subscribe(onNext:{ loading in
                
                isLoading = loading
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(isLoading)
        XCTAssertFalse(isLoading!)
    }
    
    func testError() {
        
        var error: ErrorResponse?
        let promise = expectation(description: "")
        
        sutWrong.viewDidLoad()
        sutWrong
            .getErrorObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { errorResponse in
                
                error = errorResponse
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(error)
    }
    
    func testGetCharacterRight() throws {
        
        var character: CharacterResponse?
        let promise = expectation(description: "")
        
        sutRight.viewDidLoad()
        sutRight
            .getCharacterObserver()
            .subscribe(onNext: { characterResponse in
                
                character = characterResponse
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(character)
    }
}
