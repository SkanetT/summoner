//
//  SummonerSpellCell.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerSpellCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var spellImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        spellImage.clipsToBounds = true
        spellImage.layer.cornerRadius = 8
        spellImage.layer.borderColor = UIColor.black.cgColor
        spellImage.layer.borderWidth = 1
        
    }

    
    
}
