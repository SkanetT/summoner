//
//  SpectatorCell.swift
//  LoLProject
//
//  Created by Антон on 19.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class SpectatorCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var summonerIcon: UIImageView!
    @IBOutlet weak var summonerSpell1: UIImageView!
    @IBOutlet weak var summonerSpell2: UIImageView!


    @IBOutlet weak var summonerNameLabel: UILabel!
    
    let champions = try! Realm().objects(Champion.self)
    let spells = try! Realm().objects(SummonerSpell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        summonerIcon.clipsToBounds = true
        summonerIcon.layer.cornerRadius = 25
        summonerIcon.layer.borderColor = UIColor.white.cgColor
        summonerIcon.layer.borderWidth = 1
        
        summonerSpell1.clipsToBounds = true
        summonerSpell1.layer.cornerRadius = 6
        summonerSpell1.layer.borderColor = UIColor.white.cgColor
        summonerSpell1.layer.borderWidth = 1
        
        summonerSpell2.clipsToBounds = true
        summonerSpell2.layer.cornerRadius = 6
        summonerSpell2.layer.borderColor = UIColor.white.cgColor
        summonerSpell2.layer.borderWidth = 1
        
        clipsToBounds = true
        layer.cornerRadius = 10
        
    }
    
    func setData(data: ParticipantSpectator) {
        
        guard let champion = champions.first(where: { $0.key == data.championId.description }) else { return }
        summonerNameLabel.text = data.summonerName
        summonerIcon.downloadSD(type: .profileIcon(id: data.profileIconId.description))
        background.downloadSD(type: .championWallpaper(id: champion.id, index: "0"))
        
        if let spell1 = spells.first(where: { $0.key == data.spell1Id.description }), let spell2 = spells.first(where: { $0.key == data.spell2Id.description }) {
            summonerSpell1.downloadSD(type: .spellIcon(id: spell1.id))
            summonerSpell2.downloadSD(type: .spellIcon(id: spell2.id))

        }
    }

}
