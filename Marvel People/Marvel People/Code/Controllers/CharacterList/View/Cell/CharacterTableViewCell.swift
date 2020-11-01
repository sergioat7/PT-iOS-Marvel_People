//
//  CharacterTableViewCell.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 31/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    var characterCellViewModel: CharacterCellViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
    }
}
