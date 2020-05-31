//
//  MoreInfoCell.swift
//  LoLProject
//
//  Created by Антон on 19.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    override func prepareForReuse() {
        let images = contentView.subviews.filter({ $0 is UIImageView })
        images.forEach {
            if let imageView = $0 as? UIImageView {
                imageView.sd_cancelCurrentImageLoad()
                imageView.image = nil
            }
        }
    }
    
    func setDataForEnvironment(summonerIdInGame: Int, win : Bool) {
        switch summonerIdInGame {
        case 1:
            participant1.thisView.backgroundColor = .yellow
        case 2:
            participant2.thisView.backgroundColor = .yellow
        case 3:
            participant3.thisView.backgroundColor = .yellow
        case 4:
            participant4.thisView.backgroundColor = .yellow
        case 5:
            participant5.thisView.backgroundColor = .yellow
        case 6:
            participant6.thisView.backgroundColor = .yellow
        case 7:
            participant7.thisView.backgroundColor = .yellow
        case 8:
            participant8.thisView.backgroundColor = .yellow
        case 9:
            participant9.thisView.backgroundColor = .yellow
        case 10:
            participant10.thisView.backgroundColor = .yellow
        default:
            print()
        }
        
        
        if win == true {
            if summonerIdInGame <= 5 {
                team1.backgroundColor = .green
                team1Win.text = "Win"
                team2.backgroundColor = .red
                team2Win.text = "Defeat"
            } else {
                team1.backgroundColor = .red
                team1Win.text = "Defeat"
                team2.backgroundColor = .green
                team2Win.text = "Win"
            }
        } else {
            if summonerIdInGame <= 5 {
                team1.backgroundColor = .red
                team1Win.text = "Defeat"
                team2.backgroundColor = .green
                team2Win.text = "Win"
            } else {
                team1.backgroundColor = .green
                team1Win.text = "Win"
                team2.backgroundColor = .red
                team2Win.text = "Defeat"
            }
        }
    }
    
    func setDataForParticipants(members: [Member]) {
        participant1.setData(member: members[0])
        participant2.setData(member: members[1])
        participant3.setData(member: members[2])
        participant4.setData(member: members[3])
        participant5.setData(member: members[4])
        participant6.setData(member: members[5])
        participant7.setData(member: members[6])
        participant8.setData(member: members[7])
        participant9.setData(member: members[8])
        participant10.setData(member: members[9])
    }
    
}
