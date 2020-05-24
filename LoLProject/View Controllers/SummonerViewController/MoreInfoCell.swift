//
//  MoreInfoCell.swift
//  LoLProject
//
//  Created by Антон on 19.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class MoreInfoCell: UITableViewCell {
    
    @IBOutlet weak var participant1: ParticipantInfo!
    @IBOutlet weak var participant2: ParticipantInfo!
    @IBOutlet weak var participant3: ParticipantInfo!
    @IBOutlet weak var participant4: ParticipantInfo!
    @IBOutlet weak var participant5: ParticipantInfo!

    @IBOutlet weak var participant6: ParticipantInfo!
    @IBOutlet weak var participant7: ParticipantInfo!
    @IBOutlet weak var participant8: ParticipantInfo!
    @IBOutlet weak var participant9: ParticipantInfo!
    @IBOutlet weak var participant10: ParticipantInfo!

    @IBOutlet weak var team1: UIView!
    @IBOutlet weak var team2: UIView!
    @IBOutlet weak var team1Win: UILabel!
    @IBOutlet weak var team2Win: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!

    var tapHandler: ( ()->() )?

    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)

    }
    
    @objc
    private func didTapExpand() {
        tapHandler?()
    }
    
}
