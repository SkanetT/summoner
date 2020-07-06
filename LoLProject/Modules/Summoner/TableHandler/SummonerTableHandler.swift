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
    
    func attach(_ tableView: UITableView) {
        self.tableView = tableView
        tableView.register(UINib(nibName: "MatchHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        tableView.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        tableView.delegate = self
        tableView.dataSource = self
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
                  //  self.tableView.reloadData()
                }
                
            }
            return matchHistoryCell
        } else {
            return moreInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return nil }
        
        if section == 0 {
            
            let leagueRequest = LeagueRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
            
            NetworkAPI.shared.dataTask(request: leagueRequest) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let leagueData):
                    self.header.setData(leagueData: leagueData)
                case.failure:
                    print("no league")
                }
                
            }
            
            header.tapHandler = {[] value in
                
             //   let req = RankRequest(leagueId: value, server: foundSummoner.region)
                
//                NetworkAPI.shared.dataTask(request: req) {[weak self] result in
//                    switch result{
//                    case.success(let rankData):
//                        DispatchQueue.main.async {
//                            let leagueVC = LeagueAssembler.createModule(rankData)
//                         //   self?.navigationController?.pushViewController(leagueVC, animated: true)
//                        }
//                    case .failure:
//                        print("!!!!!!!!")
//                    }
//                }
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
        
   //     if indexPath.section >= topWallpapperIndex + 5 || indexPath.section <= topWallpapperIndex - 5   {
//            if self.topWallpaper.isHidden == false {
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.topWallpaper.isHidden = true
//                    self.summonerTopButton.isHidden = false
//                }, completion: { _ in
//                    self.topWallpapperIndex = indexPath.section
//                })
//            }
        
        
     //   guard let foundSummoner = foundSummoner else { return }
//        guard indexPath.section == matchModel.count - 6 else { return }
//        matchHistoryLoad(region: foundSummoner.region, summonerName: foundSummoner.name, summonerId: foundSummoner.id)
//
        }
}

