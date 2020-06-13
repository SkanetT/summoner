//
//  CollectionViewControllerCellCollectionViewCell.swift
//  LoLProject
//
//  Created by Антон on 26.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit



class ChampionsViewControllerCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
        
    @IBOutlet var championImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        championImage.clipsToBounds = true
        championImage.layer.cornerRadius = 3.5
        championImage.layer.borderWidth = 3
        championImage.layer.borderColor = UIColor.black.cgColor
        
        nameLabel.layer.borderWidth = 1
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 2
        nameLabel.backgroundColor = .gray
        
    }
    

    
}


