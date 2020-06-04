//
//  LeagueCell.swift
//  LoLProject
//
//  Created by Антон on 03.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lpLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
