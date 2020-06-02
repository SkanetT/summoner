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
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func prepareForReuse() {
//        skillImage.sd_cancelCurrentImageLoad()
//        
//        skillDescription.text = " "
//        layoutIfNeeded()
    }
    
    func setData(isPassive: Bool, image: String, name: String, description: String) {
        
        
        DispatchQueue.main.async {
            if isPassive {
                self.skillImage.downloadSD(type: .passiveSkillImage(name: image))
            } else {
                self.skillImage.downloadSD(type: .skillImage(name: image))
            }
        }
        
        
        
        DispatchQueue.main.async {
            self.skillName.text = name
            
            self.skillDescription.attributedText = description.gettingAttributedText()
        //   self.layoutIfNeeded()

                    
        }
       
        
        
    }
}
