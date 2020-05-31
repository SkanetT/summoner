//
//  SummonerViewController.swift
//  LoLProject
//
//  Created by Антон on 05.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class SummonerViewController: UIViewController {
    
    
    @IBOutlet var mostPlayed: UIView!
    @IBOutlet var summonerIconImage: UIImageView!
    @IBOutlet var nameLebel: UILabel!
    @IBOutlet var lvlLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let dataQueue: DispatchQueue = DispatchQueue.init(label: "qqq", qos: .userInteractive)
    
    
    let header = RankView()
    let footer = MoreFooterView()
    
    var matchsArray: [ExpandableMathHistory] = []
    
    let champions = try! Realm().objects(Champion.self)
    let spells = try! Realm().objects(SummonerSpell.self)
    let summoner = try! Realm().objects(FoundSummoner.self)
    
    var matchModel: [MatchModel] = []
    

    
//    var offset = 7
//    var start = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "MatchHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        tableView.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        guard let foundSummoner = summoner.first else { return }
        let summonerName = foundSummoner.name
        let region = foundSummoner.region
        
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        
        summonerIconImage.downloadSD(type: .profileIcon(id: String(foundSummoner.profileIconId)))
        
        
        NetworkAPI.shared.fetchMatchHistory(region: region, accountId: foundSummoner.accountId) {[weak self] result in
            
            guard let self = self else{ return }
            switch result {
            case .success(let matchs):
                
                self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
                
                self.matchHistoryLoad(region: region, summonerName: summonerName)
                

            case .failure:
                print("Error matchs")
            }
        }
        
        NetworkAPI.shared.fetchMostPlayedChampions(region: foundSummoner.region,summonerId: foundSummoner.id) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let mostPlayedChampions):
                if mostPlayedChampions.count >= 3 {
                    DispatchQueue.main.async {
                        let mostView = MostPlayedView()
                        mostView.setData(mostPlayedChampions: mostPlayedChampions)
                        self.mostPlayed.addSubview(mostView)
                        mostView.leadingAnchor.constraint(equalTo: self.mostPlayed.leadingAnchor).isActive = true
                        mostView.trailingAnchor.constraint(equalTo: self.mostPlayed.trailingAnchor).isActive = true
                        mostView.topAnchor.constraint(equalTo: self.mostPlayed.topAnchor).isActive = true
                        mostView.bottomAnchor.constraint(equalTo: self.mostPlayed.bottomAnchor).isActive = true
                    }
                } else {
                    DispatchQueue.main.async {
                        let noData = NoMostPlayedView()
                        self.mostPlayed.addSubview(noData)
                        noData.leadingAnchor.constraint(equalTo: self.mostPlayed.leadingAnchor).isActive = true
                        noData.trailingAnchor.constraint(equalTo: self.mostPlayed.trailingAnchor).isActive = true
                        noData.topAnchor.constraint(equalTo: self.mostPlayed.topAnchor).isActive = true
                        noData.bottomAnchor.constraint(equalTo: self.mostPlayed.bottomAnchor).isActive = true
                    }
                }
                
            case.failure:
                print("No most Played")
            }
        }
    }
    
    @IBAction func logOffTaped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .alert)
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) {[weak self] _ in
            
            let realm = try! Realm()
            let summoner = try! Realm().objects(FoundSummoner.self)
            try! realm.write {
                realm.delete(summoner)
            }
            self?.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(logOut)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
}

extension SummonerViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        matchHistoryCell.setData(summonerInMatch: matchForSection.summonerInMatch)
        
        if matchForSection.members.count == 10 {
            
            moreInfoCell.setDataForEnvironment(summonerIdInGame: matchForSection.summonerInMatch.idInMatch, win: matchForSection.summonerInMatch.win)
            moreInfoCell.setDataForParticipants(members: matchForSection.members.self)
            
        }
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                matchHistoryCell.tapHandler = { [weak self]  in
                    guard let self = self else { return }
//                    let sectionList: IndexSet = [indexPath.section]
                    self.matchsArray[indexPath.section].isExpanded.toggle()
//                    self.tableView.beginUpdates()
//                    self.tableView.reloadSections(sectionList, with: .fade)
//                    self.tableView.endUpdates()
                    self.tableView.reloadData()
                }
                
            }
            return matchHistoryCell
        } else {
            DispatchQueue.main.async {
                moreInfoCell.tapHandler = { [weak self]  in
                    self?.matchsArray[indexPath.section].isExpanded.toggle()
                    self?.tableView.reloadData()

//                    self?.tableView.reloadSections([indexPath.section], with: .fade)
                }
            }
            return moreInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return nil }
        if section == 0 {
            NetworkAPI.shared.fetchLeagues(region: foundSummoner.region,summonerId: foundSummoner.id) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let leagueData):
                    self.header.setData(leagueData: leagueData)
                case.failure:
                    print("no league")
                }
                
            }
            return header
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 260 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let foundSummoner = summoner.first else { return }
        guard indexPath.section == matchModel.count - 6 else { return }
        matchHistoryLoad(region: foundSummoner.region, summonerName: foundSummoner.name)

    }
    
    private func reloadMatchInfo(disGroup: DispatchGroup, matchId: Int,region: String, reply: Int = 0,  summonerName: String ) {
        guard reply < 4 else {
            print("some wrong")
            disGroup.leave()
            return
        }
        NetworkAPI.shared.fetchFullInfoMatch(region: region, matchId: matchId) {[weak self] result in
            guard let self = self else { return }
                switch result {
                case.success(let fullMatchHistory):
                     self.dataQueue.sync(flags:.barrier) {
                        disGroup.leave()
                        let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName)
                        self.matchModel.append(match)
                    }
                case.failure:
                    self.reloadMatchInfo(disGroup: disGroup, matchId: matchId, region: region, reply: reply + 1, summonerName: summonerName)
//                    print("Fail section \(i) for match \(self.matchsArray[i].match.gameId)")
//                    failsMatchs += 1
                }
                
            
            
        }
    }
    
    private func matchHistoryLoad(region : String, summonerName: String) {
        let disGroup = DispatchGroup()
        var failsMatchs = 0
        
        let decValue = matchsArray.count - matchModel.count < 7 ? matchsArray.count - matchModel.count : 7
        
        for i in matchModel.count...(matchModel.count + decValue) {
            
            disGroup.enter()
            NetworkAPI.shared.fetchFullInfoMatch(region: region, matchId: self.matchsArray[i].match.gameId) {[weak self] result in
                guard let self = self else { return }
                
                switch result {
                case.success(let fullMatchHistory):
                    self.dataQueue.sync(flags:.barrier) {
                        disGroup.leave()
                        let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName)
                        self.matchModel.append(match)
                    }
                case.failure(let erorr):
                    print("####",erorr)
                    print("Fail section \(i) for match \(self.matchsArray[i].match.gameId)")
                    failsMatchs += 1
                    self.reloadMatchInfo(disGroup: disGroup, matchId: self.matchsArray[i].match.gameId, region: region, summonerName: summonerName)
                }
                
                
                
            }
            
        }
        
        disGroup.notify(queue: .main) {
            self.matchModel.sort { (lhs, rhs) -> Bool in
                return lhs.summonerInMatch.dateCreation > rhs.summonerInMatch.dateCreation
            }
            if failsMatchs != 0 {
                print (" 💡💡💡💡💡💡 Fails ⚰️ \(failsMatchs) ⚰️ 💡💡💡💡💡💡 ")
            } else {
                print("🌈🌈🌈🌈🌈🌈 All matchs good 🌈🌈🌈🌈🌈🌈")
            }
            self.tableView.reloadData()
//            self.start = self.offset + 1
        }
    }
    
}

extension UIViewController {
    func showError(apiErro: APIErrors) {
        
    }
}
