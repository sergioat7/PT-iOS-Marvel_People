//
//  CharacterCellViewModel.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 31/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

class CharacterCellViewModel {

    private let character: CharacterResponse
    
    init(character: CharacterResponse) {
        self.character = character
    }
    
    var id: Int {
        get {
            return character.id
        }
    }
    
    var name: String {
        get {
            return character.name
        }
    }
    
    var imageUrl: String {
        get {
            return character.thumbnail.getThumbnail()
        }
    }
    
    var description: String {
        get {
            return character.description
        }
    }
}
