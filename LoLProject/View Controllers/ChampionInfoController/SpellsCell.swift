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
    
    func setData(isPassive: Bool, image: String, name: String, description: String) {
        
        if isPassive {
            spellImage.downloadSD(type: .passiveSkillImage(name: image))
        } else {
            spellImage.downloadSD(type: .skillImage(name: image))
        }
        
        
        DispatchQueue.main.async {
            self.spellName.text = name
            
            self.spellDescription.attributedText = description.gettingAttributedText()
        }
        
        
        
    }
}
