//
//  SpectatorCell.swift
//  LoLProject
//
//  Created by Антон on 19.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpectatorCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var summonerIcon: UIImageView!
    @IBOutlet weak var summonerSpell1: UIImageView!
    @IBOutlet weak var summonerSpell2: UIImageView!


    @IBOutlet weak var summonerNameLabel: UILabel!
    
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
                
        guard let championId = RealmManager.fetchChampionIdfromKey(data.championId.description) else { return }
        summonerNameLabel.text = data.summonerName
        summonerIcon.downloadSD(type: .profileIcon(id: data.profileIconId.description))
        background.downloadSD(type: .championWallpaper(id: championId, index: "0"))
        
        if let spell1Id = RealmManager.fetchSpellIdfromKey(data.spell1Id.description) {
             summonerSpell1.downloadSD(type: .spellIcon(id: spell1Id))
        }
        
        if let spell2Id = RealmManager.fetchSpellIdfromKey(data.spell2Id.description) {
             summonerSpell2.downloadSD(type: .spellIcon(id: spell2Id))
        }
        
    }

}
