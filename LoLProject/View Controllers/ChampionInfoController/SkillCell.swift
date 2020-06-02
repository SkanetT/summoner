//
//  SpellsCell.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellsCell: UITableViewCell {
    
    @IBOutlet var skillImage: UIImageView!
    @IBOutlet var skillName: UILabel!
    @IBOutlet var skillDescription: UILabel!
    
    
    @IBOutlet var skillKey: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    
    func setTitles(name: String, desc: String) {
        self.skillName.text = name
        
        self.skillDescription.attributedText = description.gettingAttributedText()
    }
    
    func setData(isPassive: Bool, image: String,key: String, name: String, description: String) {
        
        self.skillName.text = name
        self.skillKey.text = key

        self.skillDescription.attributedText = description.gettingAttributedText()
        
        
            if isPassive {
                self.skillImage.downloadSD(type: .passiveSkillImage(name: image))
            } else {
                self.skillImage.downloadSD(type: .skillImage(name: image))
            }
        
    }
}
