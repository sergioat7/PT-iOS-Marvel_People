//
//  CharacterDetailApiClientTests.swift
//  Marvel PeopleTests
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Marvel_People

class CharacterDetailApiClientTests: XCTestCase {
    
    var sut: CharacterDetailApiClientProtocol!
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        
        super.setUp()
        sut = CharacterDetailApiClient()
    }

    override func tearDownWithError() throws {
        
        sut = nil
        super.tearDown()
    }
    
    func testGetCharacterRight() {
        
        var characters: CharactersResponse?
        
        let promise = expectation(description: "Get successful")
        sut.getCharacter(characterId: 1009610)
        sut
            .getCharactersDataObserver()
            .subscribe(onNext: { charactersDataResponse in
                
                characters = charactersDataResponse.data.results
                promise.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [promise], timeout: 60)
        
        XCTAssertNotNil(characters)
        XCTAssertTrue(characters!.count == 1)
    }
    
    func testGetCharacterWrong() throws {
        
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get unsuccessful")
        sut.getCharacter(characterId: 0)
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
