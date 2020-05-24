//
//  ParticipantInfo.swift
//  LoLProject
//
//  Created by Антон on 24.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ParticipantInfo: XibBasedView {
    
    @IBOutlet weak var thisView: UIView!
    
    override func awakeFromNib() {
       super.awakeFromNib()
        
    }
    let champions = try! Realm().objects(Champion.self)
    let networkAPI = NetworkAPI()
    
    @IBOutlet weak var participantNameLabel: UILabel!
    @IBOutlet weak var championIcon: UIImageView!
    @IBOutlet weak var kda: UILabel!
    


    func setData(participant: Participant, participantName: String) -> () {
        participantNameLabel.text = "\(participantName)"
        kda.text = "\(participant.stats.kills)/\(participant.stats.deaths)/\(participant.stats.assists)"
        if let champion = champions.first(where: { $0.key == String(participant.championId) }) {
            let championId = champion.id
            networkAPI.fetchImageToChampionIcon(championId: championId) {[weak self] icon in
                guard let self = self else { return }
                self.championIcon.image = icon
            }
        }
    }

}
