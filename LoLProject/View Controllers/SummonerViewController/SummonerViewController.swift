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
    @IBOutlet var matchHistory: UITableView!
    
    let dataQueue: DispatchQueue = DispatchQueue.init(label: "qqq", qos: .userInteractive)
    
    let networkAPI = NetworkAPI()

    let header = RankView()
    let footer = MoreFooterView()
    
    var matchsArray: [ExpandableMathHistory] = []

    let champions = try! Realm().objects(Champion.self)
    let spells = try! Realm().objects(SummonerSpell.self)
    
    
    var matchModel: [MatchModel] = []
    
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
        
        
        matchHistory.delegate = self
        matchHistory.dataSource = self
        matchHistory.allowsSelection = false
        
        matchHistory.register(UINib(nibName: "MatchHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        matchHistory.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return }
        let summonerName = foundSummoner.name

        let disGroup = DispatchGroup()
            networkAPI.fetchMatchHistory(accountId: foundSummoner.accountId) {[weak self] result in
                guard let self = self else{ return }
                switch result {
                case .success(let matchs):
                        self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
                        for i in 0...2 {
                            disGroup.enter()
                            self.networkAPI.fetchFullInfoMatch(matchId: self.matchsArray[i].match.gameId) {[weak self] result in
                                guard let self = self else { return }
                                defer { disGroup.leave() }
                                self.dataQueue.sync(flags:.barrier) {
                                switch result {
                                case.success(let fullMatchHistory):
                                    let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName)
                                    self.matchModel.append(match)
                                case.failure:
                                    print("!")
                                }
                                   
                            }
                                
                        }
                    }
                    disGroup.notify(queue: .main) {
                            self.matchModel.sort { (lhs, rhs) -> Bool in
                                return lhs.summonerInMatch.dateCreation > rhs.summonerInMatch.dateCreation
                            }
                            
                            self.matchHistory.reloadData()
                        }

                case .failure:
                    print("Error matchs")
                }
            }
        
        networkAPI.fetchMostPlayedChampions(summonerId: foundSummoner.id) {[weak self] result in
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
        
        
        
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(foundSummoner.profileIconId)).png")
       
        
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
        matchModel.count
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
                    self?.matchsArray[indexPath.section].isExpanded.toggle()
                    self?.matchHistory.reloadSections([indexPath.section], with: .fade)
                }
                
            }
            return matchHistoryCell
        } else {
            DispatchQueue.main.async {
            moreInfoCell.tapHandler = { [weak self]  in
                self?.matchsArray[indexPath.section].isExpanded.toggle()
                self?.matchHistory.reloadSections([indexPath.section], with: .fade)
                }
            }
        return moreInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return nil }
        if section == 0 {
            networkAPI.fetchLeagues(summonerId: foundSummoner.id) {[weak self] result in
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
        
        
    }
}


