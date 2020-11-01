//
//  CharacterListDataManagerTests.swift
//  Marvel PeopleTests
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Marvel_People

class CharacterListDataManagerTests: XCTestCase {
    
    var sut: CharacterListDataManagerProtocol!
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        
        super.setUp()
        sut = CharacterListDataManager(apiClient: CharacterListApiClient())
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }
    
    func testGetDefaultCharacters() {
        
        var characters: CharactersResponse?
        
        let promise = expectation(description: "Search successful")
        sut.getCharacters(search: nil)
        sut
            .getCharactersObserver()
            .subscribe(onNext: { charactersResponse in
                
                characters = charactersResponse
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(characters)
        XCTAssertTrue(characters!.count > 0)
    }
    
    func testSearchCharactersRight() {
        
        var characters: CharactersResponse?
        
        let promise = expectation(description: "Search successful")
        sut.getCharacters(search: "spider")
        sut
            .getCharactersObserver()
            .subscribe(onNext: { charactersResponse in
                
                characters = charactersResponse
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(characters)
        XCTAssertTrue(characters!.count > 0)
    }
    
    func testSearchCharactersWrong() throws {
        
        var error: ErrorResponse?
        
        let promise = expectation(description: "Search unsuccessful")
        sut.getCharacters(search: "")
        sut
            .getErrorObserver()
            .subscribe(onNext: { errorResponse in
                
                error = errorResponse
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(error)
    }
}
