//
//  CollectionViewCell.swift
//  LoLProject
//
//  Created by Антон on 31.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class CellForHeaderForChampion: UICollectionViewCell {
    
    @IBOutlet weak var skinName: UILabel!
    @IBOutlet weak var skinImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        skinName.alpha = 0.5
        skinName.clipsToBounds = true
        
        skinName.layer.borderWidth = 1
        skinName.layer.borderColor = UIColor.white.cgColor
    }

}
