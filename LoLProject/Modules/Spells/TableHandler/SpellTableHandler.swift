//
//  SpellTableHandler.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellTableHandler: NSObject, SpellTableHandlerProtocol {
    
    
    
    private weak var tableView: UITableView?
    var spellList: [SpellModel] = []
    
    func attach(_ tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func updateData(_ spellList: [SpellModel]) {
        self.spellList = spellList
        tableView?.reloadData()
    }
    
}

extension SpellTableHandler: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summonerSpell", for: indexPath) as! SummonerSpellCell
        cell.selectionStyle = .none
        cell.nameLabel.text = spellList[indexPath.row].spellName
        cell.descriptionLabel.text = spellList[indexPath.row].spellDesc
        cell.spellImage.downloadSD(type: .spellIcon(id: spellList[indexPath.row].spellImgId))
        return cell
    }
    
}


