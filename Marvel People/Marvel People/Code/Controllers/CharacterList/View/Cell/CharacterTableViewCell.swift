//
//  CharacterTableViewCell.swift
//  Marvel People
//
//  Created by Sergio Aragonés on 31/10/2020.
//  Copyright (c) 2020 Sergio Aragonés. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbMoreInfo: UILabel!
    
    var characterCellViewModel: CharacterCellViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        
        ivCharacter.roundCorners([UIRectCorner.topLeft, UIRectCorner.bottomLeft], radius: 20)
        
        if let image = characterCellViewModel?.imageUrl, let imageUrl = URL(string: image) {

            ivCharacter.kf.indicatorType = .activity
            ivCharacter.kf.setImage(with: imageUrl)
        } else {
            ivCharacter.image = nil
        }
        
        lbName.text = characterCellViewModel?.name ?? ""
        lbDescription.text = characterCellViewModel?.description ?? ""
        lbMoreInfo.text = "MORE_INFO".localized()
    }
}
