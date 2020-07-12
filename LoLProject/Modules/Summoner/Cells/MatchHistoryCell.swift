//
//  MachHistoryCell.swift
//  LoLProject
//
//  Created by Антон on 12.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class MatchHistoryCell: UITableViewCell {
    @IBOutlet var test: UILabel!
    
    @IBOutlet var stack: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var championIcon: UIImageView!
    @IBOutlet weak var winOrLose: UIView!
    @IBOutlet weak var kda: UILabel!
    @IBOutlet weak var typeAndWin: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    
    @IBOutlet weak var spell1: UIImageView!
    @IBOutlet weak var spell2: UIImageView!
    
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
        clipsToBounds = true
        layer.borderWidth = 2
        championIcon.clipsToBounds = true
        championIcon.layer.cornerRadius = championIcon.frame.height / 2
        championIcon.layer.borderColor = UIColor.white.cgColor
        championIcon.layer.borderWidth = 2
        moreButton.clipsToBounds = true
        moreButton.layer.cornerRadius = 10
        
        winOrLose.clipsToBounds = true
        winOrLose.layer.cornerRadius = 10
        
        dateAndTime.clipsToBounds = true
        dateAndTime.layer.cornerRadius = 7
        dateAndTime.layer.borderWidth = 1.5
        dateAndTime.layer.borderColor = UIColor.black.cgColor
        
        moreButton.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    func setData(summonerInMatch: SummonerInMatch) {
        kda.text = summonerInMatch.kda
        typeAndWin.text = summonerInMatch.matchType
        
        if summonerInMatch.win == true {
            typeAndWin.backgroundColor = .green
        } else {
            typeAndWin.backgroundColor = .red
        }
        
        dateAndTime.text = "\(summonerInMatch.date) \(summonerInMatch.time) "
        
        if let championId = RealmManager.fetchChampionIdfromKey(summonerInMatch.championKey) {
            championIcon.downloadSD(type: .championIcon(id: championId))
        }
        
        if let spell1Id = RealmManager.fetchSpellIdfromKey(summonerInMatch.spellKey1) {
            spell1.downloadSD(type: .spellIcon(id: spell1Id))
        }
        
        if let spell2Id = RealmManager.fetchSpellIdfromKey(summonerInMatch.spellKey2) {
            spell2.downloadSD(type: .spellIcon(id: spell2Id))
        }
        item0.downloadSD(type: .itemIcon(id: summonerInMatch.firstItemId))
        item1.downloadSD(type: .itemIcon(id: summonerInMatch.secondItemId))
        item2.downloadSD(type: .itemIcon(id: summonerInMatch.thirdItemId))
        item3.downloadSD(type: .itemIcon(id: summonerInMatch.fourthItemId))
        item4.downloadSD(type: .itemIcon(id: summonerInMatch.fifthItemId))
        item5.downloadSD(type: .itemIcon(id: summonerInMatch.sixthItemId))
        item6.downloadSD(type: .itemIcon(id: summonerInMatch.wardId))
    }
}


