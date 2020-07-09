//
//  SummonerTableHandler.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerTableHandler: NSObject, SummonerTableHandlerProtocol {
    
    
    private weak var tableView: UITableView?
    
    let header = RankView()
    var matchsArray: [ExpandableMathHistory] = []
    var matchModel: [MatchModel] = []
    var topWallpapperIndex = 0
    var upgrade: (() -> ())?
    var hide: ((Int) -> ())?
    var league: ((String) -> ())?


    
    func attach(_ tableView: UITableView) {
        self.tableView = tableView
        tableView.register(UINib(nibName: "MatchHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        tableView.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setStartData(matchsArray: [ExpandableMathHistory], matchModel: [MatchModel]) {
        self.matchsArray = matchsArray
        self.matchModel = matchModel
        tableView?.reloadData()
    }
    
    func updateData(_ matchModel: [MatchModel]) {
        self.matchModel = matchModel
        tableView?.reloadData()
       }
    
    func setDataForHeader(_ data: LeagueData) {
        header.setData(leagueData: data)
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func setUpgrade(_ reload: (() -> ())?) {
        self.upgrade = reload
    }
    
    func hideTop(_ hide: ((Int) -> ())?) {
        self.hide = hide
    }
    
    func setLeague(_ league: ((String) -> ())?) {
        self.league = league
    }
    
    
    func updateIndex(_ index: Int) {
        self.topWallpapperIndex = index
      }
}

extension SummonerTableHandler: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchsArray[section].isExpanded ? 2 : 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let matchHistoryCell = tableView.dequeueReusableCell(withIdentifier: "mach", for: indexPath) as! MatchHistoryCell
        let moreInfoCell = tableView.dequeueReusableCell(withIdentifier: "moreInfo", for: indexPath) as! MoreInfoCell
        
        let matchForSection = matchModel[indexPath.section]
        
        matchHistoryCell.clipsToBounds = true
        matchHistoryCell.layer.cornerRadius = 6
        moreInfoCell.clipsToBounds = true
        moreInfoCell.layer.cornerRadius = 6
        
        matchHistoryCell.setData(summonerInMatch: matchForSection.summonerInMatch)
        
        if matchForSection.members.count == 10 {
            
            moreInfoCell.setDataForEnvironment(summonerIdInGame: matchForSection.summonerInMatch.idInMatch, win: matchForSection.summonerInMatch.win)
            moreInfoCell.setDataForParticipants(members: matchForSection.members.self)
            
            
        }
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                matchHistoryCell.tapHandler = { [weak self]  in
                    guard let self = self else { return }
                    self.matchsArray[indexPath.section].isExpanded.toggle()
                    self.tableView?.reloadData()
                }
                
            }
            return matchHistoryCell
        } else {
            return moreInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        if section == 0 {
            
            header.tapHandler = {[weak self] value in
                self?.league?(value)
                
            }
            return header
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 280 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section >= topWallpapperIndex + 5 || indexPath.section <= topWallpapperIndex - 5   {
            
            hide?(indexPath.section)
            
        }
        
        guard indexPath.section == matchModel.count - 6 else { return }
        upgrade?()
    }
}
