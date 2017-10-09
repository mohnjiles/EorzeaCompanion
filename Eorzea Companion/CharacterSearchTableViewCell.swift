//
//  CharacterSearchTableViewCell.swift
//  Eorzea Companion
//
//  Created by JT Miles on 10/8/17.
//  Copyright © 2017 JT Miles. All rights reserved.
//

import UIKit
import Siesta

class CharacterSearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: RemoteImageView!
    @IBOutlet weak var characterServerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        characterImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
