//
//  CharacterDetailDataManagerTests.swift
//  Marvel PeopleTests
//
//  Created by Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Marvel_People

class CharacterDetailDataManagerTests: XCTestCase {
    
    var sutRight: CharacterDetailDataManagerProtocol!
    var sutWrong: CharacterDetailDataManagerProtocol!
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        
        super.setUp()
        sutRight = CharacterDetailDataManager(apiClient: CharacterDetailApiClient(),
                                              characterId: 1009610)
        sutWrong = CharacterDetailDataManager(apiClient: CharacterDetailApiClient(),
                                              characterId: 0)
    }

    override func tearDownWithError() throws {
        
        sutRight = nil
        sutWrong = nil
        super.tearDown()
    }
    
    func testGetCharacterRight() {
        
        var character: CharacterResponse?
        
        let promise = expectation(description: "Get successful")
        sutRight.getCharacter()
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
    
    func testGetCharacterWrong() throws {
        
        var error: ErrorResponse?
        
        let promise = expectation(description: "Get unsuccessful")
        sutWrong.getCharacter()
        sutWrong
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
