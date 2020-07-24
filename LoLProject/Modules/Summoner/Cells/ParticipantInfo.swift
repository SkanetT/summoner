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
        
        championIcon.clipsToBounds = true
        championIcon.layer.cornerRadius = 10
        championIcon.layer.borderWidth = 1
        championIcon.layer.borderColor = UIColor.white.cgColor
        
        firstSpell.clipsToBounds = true
        firstSpell.layer.cornerRadius = 4
        firstSpell.layer.borderWidth = 1
        firstSpell.layer.borderColor = UIColor.black.cgColor
        
        secondSpell.clipsToBounds = true
        secondSpell.layer.cornerRadius = 4
        secondSpell.layer.borderWidth = 1
        secondSpell.layer.borderColor = UIColor.black.cgColor
        
        item0.clipsToBounds = true
        item0.layer.cornerRadius = 4
        item0.layer.borderWidth = 1
        item0.layer.borderColor = UIColor.white.cgColor
        
        item1.clipsToBounds = true
        item1.layer.cornerRadius = 4
        item1.layer.borderWidth = 1
        item1.layer.borderColor = UIColor.white.cgColor
        
        item2.clipsToBounds = true
        item2.layer.cornerRadius = 4
        item2.layer.borderWidth = 1
        item2.layer.borderColor = UIColor.white.cgColor
        
        item3.clipsToBounds = true
        item3.layer.cornerRadius = 4
        item3.layer.borderWidth = 1
        item3.layer.borderColor = UIColor.white.cgColor
        
        item4.clipsToBounds = true
        item4.layer.cornerRadius = 4
        item4.layer.borderWidth = 1
        item4.layer.borderColor = UIColor.white.cgColor
        
        item5.clipsToBounds = true
        item5.layer.cornerRadius = 4
        item5.layer.borderWidth = 1
        item5.layer.borderColor = UIColor.white.cgColor
        
        item6.clipsToBounds = true
        item6.layer.cornerRadius = 4
        item6.layer.borderWidth = 1
        item6.layer.borderColor = UIColor.white.cgColor
    }
    
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
    
    var tapHandler: ((String) -> ())?
    
    func setData(member: Member) -> () {
        
        participantNameLabel.text = member.name
        kda.text = member.kda
        
        if let championId = RealmManager.fetchChampionIdfromKey(member.championKey) {
            championIcon.downloadSD(type: .championIcon(id: championId))
        }
        
        
        if let spell1id = RealmManager.fetchSpellIdfromKey(member.spellKey1) {
            firstSpell.downloadSD(type: .spellIcon(id: spell1id))
        }
        
        if let spell2id = RealmManager.fetchSpellIdfromKey(member.spellKey2) {
            secondSpell.downloadSD(type: .spellIcon(id: spell2id))
        }
        
        tapHandler = member.tapHandler
        
        item0.downloadSD(type: .itemIcon(id: member.firstItemId))
        item1.downloadSD(type: .itemIcon(id: member.secondItemId))
        item2.downloadSD(type: .itemIcon(id: member.thirdItemId))
        item3.downloadSD(type: .itemIcon(id: member.fourthItemId))
        item4.downloadSD(type: .itemIcon(id: member.fifthItemId))
        item5.downloadSD(type: .itemIcon(id: member.sixthItemId))
        item6.downloadSD(type: .itemIcon(id: member.wardId))
        
    }
    
    override func setupUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(gesture)
    }
    
    @objc
    private func didTap() {
        guard let name = participantNameLabel.text else { return }
        tapHandler?(name)
    }
}
