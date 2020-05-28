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
    let spells = try! Realm().objects(SummonerSpell.self)
    let networkAPI = NetworkAPI()
    
    
    @IBOutlet weak var participantNameLabel: UILabel!
    @IBOutlet weak var championIcon: UIImageView!
    @IBOutlet weak var kda: UILabel!
    
    @IBOutlet weak var firstSpell: UIImageView!
    @IBOutlet weak var secondSpell: UIImageView!

    @IBOutlet weak var item0: UIImageView!
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    @IBOutlet weak var item4: UIImageView!
    @IBOutlet weak var item5: UIImageView!
    @IBOutlet weak var item6: UIImageView!


    func setData(member: Member) -> () {
        participantNameLabel.text = member.name
        kda.text = member.kda
        if let champion = champions.first(where: { $0.key == member.championKey }) {
            let championId = champion.id
            networkAPI.fetchImageToChampionIcon(championId: championId) {[weak self] icon in
                guard let self = self else { return }
                self.championIcon.image = icon
            }
        }
        
        if let spell1 = spells.first(where: { $0.key == member.spellKey1 }), let spell2 = spells.first(where: { $0.key == member.spellKey2 }) {
            let spell1Id = spell1.id
            let spell2Id = spell2.id
            networkAPI.fetchImageToSummonerSpell(spellId: spell1Id) {[weak self] icon in
                self?.firstSpell.image = icon
            }
            networkAPI.fetchImageToSummonerSpell(spellId: spell2Id) {[weak self] icon in
                self?.secondSpell.image = icon
                
            }
        }
        
        
        networkAPI.fetchImageToItem(itemId: member.firstItemId) {[weak self] icon in
            self?.item0.image = icon
        }
        networkAPI.fetchImageToItem(itemId: member.secondItemId) {[weak self] icon in
            self?.item1.image = icon
        }
        networkAPI.fetchImageToItem(itemId: member.thirdItemId) {[weak self] icon in
            self?.item2.image = icon
        }
        networkAPI.fetchImageToItem(itemId: member.fourthItemId) {[weak self] icon in
            self?.item3.image = icon
        }
        networkAPI.fetchImageToItem(itemId: member.fifthItemId) {[weak self] icon in
            self?.item4.image = icon
        }
        networkAPI.fetchImageToItem(itemId: member.sixthItemId) {[weak self] icon in
            self?.item5.image = icon
        }
        networkAPI.fetchImageToItem(itemId: member.wardId) {[weak self] icon in
            self?.item6.image = icon
        }

    }

}
