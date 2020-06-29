//
//  LeagueTableHandler.swift
//  LoLProject
//
//  Created by Антон on 28.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueTableHandler: NSObject, LeagueTableHandlerProtocol {
    
    
    
    private weak var tableView: UITableView?
    let foundSummoner = RealmManager.fetchFoundSummoner()

    var currectTier: [Entry] = []
    
    func attach(_ tableView: UITableView) {
        self.tableView = tableView
    }
    
    func updateData(tier: [Entry]) {
        self.currectTier = tier
        tableView?.reloadData()
    }
}

extension LeagueTableHandler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currectTier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        
        guard let foundSommonerName = foundSummoner?.name  else { return cell }
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        
        if indexPath.row == 0 {
            cell.backgroundColor = .gray
            cell.nameLabel.text = "Summoner"
            cell.winLabel.text = "Wins"
            cell.lpLabel.text = "Points"
        } else {
            
            cell.selectionStyle = .none
            cell.nameLabel.text = currectTier[indexPath.row - 1].summonerName
            cell.lpLabel.text = currectTier[indexPath.row - 1].leaguePoints.description
            cell.winLabel.text = currectTier[indexPath.row - 1].wins.description
            cell.backgroundColor = .white
            
            if foundSommonerName == currectTier[indexPath.row - 1].summonerName {
                cell.backgroundColor = .yellow
            }
        }
        
        return cell
    }
}
