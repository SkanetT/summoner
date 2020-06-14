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
 //   let networkAPI = NetworkAPI()
    
    
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
            championIcon.downloadSD(type: .championIcon(id: champion.id))
        }
        
        if let spell1 = spells.first(where: { $0.key == member.spellKey1 }), let spell2 = spells.first(where: { $0.key == member.spellKey2 }) {
            firstSpell.downloadSD(type: .spellIcon(id: spell1.id))
            secondSpell.downloadSD(type: .spellIcon(id: spell2.id))
            
        }
        
        
        item0.downloadSD(type: .itemIcon(id: member.firstItemId))
        item1.downloadSD(type: .itemIcon(id: member.secondItemId))
        item2.downloadSD(type: .itemIcon(id: member.thirdItemId))
        item3.downloadSD(type: .itemIcon(id: member.fourthItemId))
        item4.downloadSD(type: .itemIcon(id: member.fifthItemId))
        item5.downloadSD(type: .itemIcon(id: member.sixthItemId))
        item6.downloadSD(type: .itemIcon(id: member.wardId))
        
    }
}
