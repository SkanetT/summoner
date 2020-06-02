//
//  CellForInfoView.swift
//  LoLProject
//
//  Created by Антон on 01.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class CellForInfoView: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var textCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
}
