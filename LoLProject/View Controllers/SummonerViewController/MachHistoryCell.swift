//
//  MachHistoryCell.swift
//  LoLProject
//
//  Created by Антон on 12.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class MachHistoryCell: UITableViewCell {
    @IBOutlet var test: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var championIcon: UIImageView!
    @IBOutlet weak var winOrLose: UIView!
    @IBOutlet weak var kda: UILabel!
    @IBOutlet weak var typeAndWin: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    
    @IBOutlet weak var Spell1: UIImageView!
    @IBOutlet weak var Spell2: UIImageView!
    
    @IBOutlet weak var item0: UIImageView!
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    @IBOutlet weak var item4: UIImageView!
    @IBOutlet weak var item5: UIImageView!

    @IBOutlet weak var item6: UIImageView!


    
    var tapHandler: ( ()->() )?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    private func didTapExpand() {
        tapHandler?()
    }
    
}
