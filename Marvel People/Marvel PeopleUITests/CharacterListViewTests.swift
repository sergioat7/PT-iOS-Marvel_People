//
//  CharacterListViewTests.swift
//  Marvel PeopleUITests
//
//  Created by 2020 Sergio Aragonés on 01/11/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import XCTest

class CharacterListViewTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testGetDefaultCharacters() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssert(app.navigationBars[localized("MARVEL_CHARACTERS")].searchFields[localized("SEARCH_CHARACTERS")].title.isEmpty)
        
        XCTAssert(app.tables.children(matching: .cell).element(boundBy: 0).exists)
    }
    
    func testGoToCharacterDetail() throws {
        
        app.launchArguments.append("--uitesting")
        app.launch()
        
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
    }
    
    // MARK: - Private functions
    
    private func localized(_ key: String) -> String {
        
        let uiTestBundle = Bundle(for: CharacterListViewTests.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }
}
