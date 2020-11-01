//
//  CharacterListViewModelTests.swift
//  Marvel PeopleTests
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Marvel_People

class CharacterListViewModelTests: XCTestCase {
    
    var sut: CharacterListViewModelProtocol!
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        
        super.setUp()
        sut = CharacterListViewModel(dataManager: CharacterListDataManager(apiClient: CharacterListApiClient()))
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }
    
    func testLoading() {
        
        var isLoading: Bool?
        let promise = expectation(description: "")
        
        sut.viewDidLoad()
        sut
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
        
        sut.setSearch(search: "")
        sut.viewDidLoad()
        sut
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
    
    func testSearchPhotosRight() throws {
        
        var characters: [CharacterCellViewModel]?
        let promise = expectation(description: "")
        
        sut.setSearch(search: "spider")
        sut.viewDidLoad()
        sut
            .getCharacterCellViewModelsObserver()
            .subscribe(onNext: { charactersResponse in
                
                characters = charactersResponse
                if (charactersResponse.count > 0) {
                    promise.fulfill()
                }
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 120)
        
        XCTAssertNotNil(characters)
        XCTAssertTrue(characters!.count > 0)
        XCTAssertTrue(sut.getCharacterCellViewModelsObserverValue().count > 0)
    }
    
    func testSearchPhotosWrong() throws {
        
        var characters: [CharacterCellViewModel]?
        let promise = expectation(description: "")
        
        sut.setSearch(search: "")
        sut.viewDidLoad()
        sut
            .getCharacterCellViewModelsObserver()
            .subscribe(onNext: { charactersResponse in
                
                characters = charactersResponse
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(characters)
        XCTAssertTrue(characters!.count == 0)
    }
    
    func testReloadDataRight() throws {
        
        sut.reloadData()
        XCTAssertTrue(sut.getCharacterCellViewModelsObserverValue().count == 0)
    }
}
