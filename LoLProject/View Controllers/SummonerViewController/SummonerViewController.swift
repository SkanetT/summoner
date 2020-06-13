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
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    let dataQueue: DispatchQueue = DispatchQueue.init(label: "qqq", qos: .userInteractive)
    
    var delegate: LoginControllerDelegate?
    let refrechControll: UIRefreshControl = {
        let refrechControll = UIRefreshControl()
        refrechControll.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refrechControll
    }()
    
    let header = RankView()
    let footer = MoreFooterView()
    
    var matchsArray: [ExpandableMathHistory] = []
    
    let champions = try! Realm().objects(Champion.self)
    let spells = try! Realm().objects(SummonerSpell.self)
    let summoner = try! Realm().objects(FoundSummoner.self)
    
    var matchModel: [MatchModel] = []
    
    
    @objc private func refresh(sender: UIRefreshControl){
        
        sender.endRefreshing()
    }
    
    //MARK: ViewDidLoad
    
    
    @objc func handleMenu(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summonerIconImage.clipsToBounds = true
        summonerIconImage.layer.cornerRadius = 6
        summonerIconImage.layer.borderColor = UIColor.black.cgColor
        summonerIconImage.layer.borderWidth = 3
        
        indicator.isHidden = false
        indicator.startAnimating()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .default
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.refreshControl = refrechControll
        
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        
        tableView.register(UINib(nibName: "MatchHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        tableView.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        
        guard let foundSummoner = summoner.first else { return }
        let summonerName = foundSummoner.name
        let region = foundSummoner.region
        
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        
        summonerIconImage.downloadSD(type: .profileIcon(id: String(foundSummoner.profileIconId)))
        
        
        let matchHistoryRequest = MatchHistoryRequest.init(accountId: foundSummoner.accountId, server: region)
        
        NetworkAPI.shared.dataTask(request: matchHistoryRequest) {[weak self] result in
            
            guard let self = self else{ return }
            switch result {
            case .success(let matchs):
                
                self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
                
                self.matchHistoryLoad(region: region, summonerName: summonerName)
                
                
            case .failure(let error):
                print(error)
               
            }
        }
        
        
        let mostPlayedChampionsRequest = MostPlayedChampionsRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
        
        
        NetworkAPI.shared.dataTask(request: mostPlayedChampionsRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let mostPlayedChampions):
                
                if mostPlayedChampions.count >= 3 {
                    DispatchQueue.main.async {
                        
                        self.indicator.isHidden = true
                        self.indicator.stopAnimating()
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
                        self.indicator.isHidden = true
                        self.indicator.stopAnimating()
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
                    
                    self.tableView.reloadData()
                }
                
            }
            return matchHistoryCell
        } else {
            DispatchQueue.main.async {
                moreInfoCell.tapHandler = { [weak self]  in
                    self?.matchsArray[indexPath.section].isExpanded.toggle()
                    self?.tableView.reloadData()
                }
            }
            return moreInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return nil }
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
            
            header.tapHandler = { value in
                
                
                let leagueVC = LeagueController()
                
                let req = RankRequest(leagueId: value, server: foundSummoner.region)
                
                
                NetworkAPI.shared.dataTask(request: req) { result in
                    switch result{
                    case.success(let rankData):
                        leagueVC.rankData = rankData
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(leagueVC, animated: true)
                        }
                    case .failure:
                        print("!!!!!!!!")
                    }
                    
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
            print("not reload 🧻")
            disGroup.leave()
            return
        }
        
        let fullInfoMatch = FullInfoMatchRequest.init(matchId: String(matchId), server: region)
        
        NetworkAPI.shared.dataTask(request: fullInfoMatch) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let fullMatchHistory):
                self.dataQueue.sync(flags:.barrier) {
                    print("reload 🩸")
                    disGroup.leave()
                    let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName)
                    self.matchModel.append(match)
                }
            case.failure:
                self.reloadMatchInfo(disGroup: disGroup, matchId: matchId, region: region, reply: reply + 1, summonerName: summonerName)
                
            }
            
            
            
        }
        
    }
    
    private func matchHistoryLoad(region : String, summonerName: String) {
        let disGroup = DispatchGroup()
        var failsMatchs = 0
        
        let decValue = matchsArray.count - matchModel.count < 7 ? matchsArray.count - matchModel.count - 1 : 7
        guard decValue > 1 else { return }
        
        for i in matchModel.count...(matchModel.count + decValue) {
            
            disGroup.enter()
            
            let fullInfoMatch = FullInfoMatchRequest.init(matchId: String(self.matchsArray[i].match.gameId), server: region)
            
            NetworkAPI.shared.dataTask(request: fullInfoMatch) {[weak self] result in
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
        }
    }
    
}

extension UIViewController {
    func showError(apiErro: APIErrors) {
        
    }
}


