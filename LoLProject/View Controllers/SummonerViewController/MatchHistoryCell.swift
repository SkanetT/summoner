//
//  MachHistoryCell.swift
//  LoLProject
//
//  Created by Антон on 12.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class MatchHistoryCell: UITableViewCell {
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


    let networkAPI = NetworkAPI()
    var tapHandler: ( ()->() )?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc
    private func didTapExpand() {
        tapHandler?()
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
        
        let champions = try! Realm().objects(Champion.self)
        
        if let champion = champions.first(where: {$0.key == summonerInMatch.championKey}) {
        
            networkAPI.fetchImageToChampionIcon(championId: champion.id) {[weak self] icon in
                self?.championIcon.image = icon
            
            }
        }
        
        networkAPI.fetchImageToItem(itemId: summonerInMatch.firstItemId) {[weak self] icon in
            self?.item0.image = icon
        }
               
        networkAPI.fetchImageToItem(itemId: summonerInMatch.secondItemId) {[weak self] icon in
            self?.item1.image = icon
        }
               
        networkAPI.fetchImageToItem(itemId: summonerInMatch.thirdItemId) {[weak self] icon in
            self?.item2.image = icon
        }
               
        networkAPI.fetchImageToItem(itemId: summonerInMatch.fourthItemId) {[weak self] icon in
            self?.item3.image = icon
        }
               
        networkAPI.fetchImageToItem(itemId: summonerInMatch.fifthItemId) {[weak self] icon in
            self?.item4.image = icon
        }
               
        networkAPI.fetchImageToItem(itemId: summonerInMatch.sixthItemId) {[weak self] icon in
            self?.item5.image = icon
        }
               
        networkAPI.fetchImageToItem(itemId: summonerInMatch.wardId) {[weak self] icon in
            self?.item6.image = icon
        }
        
        let spells = try! Realm().objects(SummonerSpell.self)
        
        if let spell1 = spells.first(where: { $0.key == summonerInMatch.spellKey1 }), let spell2 = spells.first(where: { $0.key == summonerInMatch.spellKey2 }) {
            networkAPI.fetchImageToSummonerSpell(spellId: spell1.id) {[weak self] icon in
                self?.Spell1.image = icon
            }
            networkAPI.fetchImageToSummonerSpell(spellId: spell2.id) {[weak self] icon in
                self?.Spell2.image = icon
            }
        }
        
    }
    
}
