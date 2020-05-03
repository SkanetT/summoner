//
//  SpellsCell.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellsCell: UITableViewCell {
    
    @IBOutlet var spellImage: UIImageView!
    @IBOutlet var spellName: UILabel!
    @IBOutlet var spellDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
