//
//  ChampionInfoTableHandler.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionInfoTableHandler: NSObject, ChampionInfoTableHandlerProtocol {
    
    private weak var tableView: UITableView?
    
    var championData: SelectedChampion?
    var id: String?
    
    let footer = FooterForChampion()
    let header = HeaderForChampion()
    
    func attach(_ tableView: UITableView) {
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SkillCell", bundle: nil), forCellReuseIdentifier: "skill")
    }
    
    func setData(_ data: SelectedChampion, _ id: String) {
        self.championData = data
        self.id = id
        tableView?.reloadData()
    }
}

extension ChampionInfoTableHandler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skill", for: indexPath) as! SpellsCell
        guard let championData = championData else { return cell }
        
        switch indexPath.row {
            
        case 0:
            cell.setData(isPassive: true, image: championData.passiveImage, key: "Passive", name: championData.passiveName, description: championData.passiveDescription)
        case 1:
            cell.setData(isPassive: false, image: championData.qImage, key: "[Q]", name: championData.qName, description: championData.qDescription)
        case 2:
            cell.setData(isPassive: false, image: championData.wImage, key: "[W]", name: championData.wName, description: championData.wDescription)
        case 3:
            cell.setData(isPassive: false, image: championData.eImage, key: "[E]", name: championData.eName, description: championData.eDescription)
        case 4:
            cell.setData(isPassive: false, image: championData.rImage, key: "[R]", name: championData.rName, description: championData.rDescription)
        default:
            
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let championData = championData, let id = id else { return nil}
        header.setData(id: id, skins: championData.skins, name: championData.name, title: championData.title)
        
        return header
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let championData = championData else { return nil}
        
        footer.setData(lore: championData.lore)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
