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
    
    let networkAPI = NetworkAPI()

    let header = RankView()
    let footer = MoreFooterView()
    
//    var limit = 0
//    var typeMatch = 0
    
    var matchsArray: [ExpandableMathHistory] = []
    let champions = try! Realm().objects(Champion.self)
    let spells = try! Realm().objects(SummonerSpell.self)
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: true)
       }
       
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: true)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        matchHistory.delegate = self
        matchHistory.dataSource = self
        matchHistory.allowsSelection = false
        
        matchHistory.register(UINib(nibName: "MachHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        matchHistory.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return }
        
        
        
        networkAPI.fetchMatchHistory(accountId: foundSummoner.accountId) { result in
            switch result {
            case .success(let matchs):
                self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
//                self.limit = 10
//                self.typeMatch = 1
                DispatchQueue.main.async {
                    self.matchHistory.reloadData()
                }

            case .failure:
                print("Error matchs")
            }
        }
        
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(foundSummoner.profileIconId)).png")
       
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
                print("????")
            }
        }
    }

    @IBAction func logOffTaped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .alert)
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) {_ in

            let realm = try! Realm()
            let summoner = try! Realm().objects(FoundSummoner.self)
            try! realm.write {
                realm.delete(summoner)
            }
            self.navigationController?.popViewController(animated: true)
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
        return matchsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let matchCell = tableView.dequeueReusableCell(withIdentifier: "mach", for: indexPath) as! MachHistoryCell
        let moreCell = tableView.dequeueReusableCell(withIdentifier: "moreInfo", for: indexPath) as! MoreInfoCell
        let championKey = String(self.matchsArray[indexPath.section].match.champion)
        
        
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return matchCell }
        
        let matchId = self.matchsArray[indexPath.section].match.gameId
        
        
        networkAPI.fetchFullInfoMatch(matchId: matchId) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let fullInfoMatch):
                
                DispatchQueue.main.async {
                    
                    
                    if let myPlayerIdentities = fullInfoMatch.participantIdentities.first(where: {$0.player.summonerName == foundSummoner.name}) {
                        let myIdInGame = myPlayerIdentities.participantId
                        if let myPlayer = fullInfoMatch.participants.first(where: {$0.participantId == myIdInGame}) {
                            
                            if let spell1 = self.spells.first(where: {$0.key == String(myPlayer.spell1Id)}), let spell2 = self.spells.first(where: {$0.key == String(myPlayer.spell2Id)}) {
                                matchCell.Spell1.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(spell1.id).png")
                                matchCell.Spell2.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(spell2.id).png")
                                
                            }
                            


                            imageForItem(item: myPlayer.stats.item0) { imageData in
                                matchCell.item0.image = imageData
                            }
                            imageForItem(item: myPlayer.stats.item1) { imageData in
                                matchCell.item1.image = imageData
                            }
                            imageForItem(item: myPlayer.stats.item2) { imageData in
                                matchCell.item2.image = imageData
                            }
                            imageForItem(item: myPlayer.stats.item3) { imageData in
                                matchCell.item3.image = imageData
                            }
                            imageForItem(item: myPlayer.stats.item4) { imageData in
                                matchCell.item4.image = imageData
                            }
                            imageForItem(item: myPlayer.stats.item5) { imageData in
                                matchCell.item5.image = imageData
                            }
                            
                            
                            imageForItem(item: myPlayer.stats.item6) { imageData in
                                matchCell.item6.image = imageData
                            }
                            

                            matchCell.timeAndDate.text = "\(dateFromGameCreation(time: fullInfoMatch.gameCreation))"
                            matchCell.kda.text = "\(myPlayer.stats.kills) / \(myPlayer.stats.deaths) / \(myPlayer.stats.assists)"
                            if myPlayer.stats.win == true {
                                matchCell.winOrLose.backgroundColor = .green
                            } else {
                                matchCell.winOrLose.backgroundColor = .red
                            }
                        }
                    }
                }
                
            case .failure:
                print("No full info")
            }
        }
        
        
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                matchCell.tapHandler = { [weak self]  in
                    self?.matchsArray[indexPath.section].isExpanded.toggle()
                    self?.matchHistory.reloadSections([indexPath.section], with: .fade)
                    
                }
                
//                matchCell.dateLabel.text = strDate
                
                if let champion = self.champions.first(where: {$0.key == championKey}) {
                
                    self.networkAPI.fetchImageToChampionIcon(championId: champion.id) { icon in
                        matchCell.championIcon.image = icon
                    
                    }
                }
            }
            return matchCell
        } else {
            if let champion = self.champions.first(where: {$0.key == championKey}) {
                DispatchQueue.main.async {
                    moreCell.testLeb.text = dateFromGameCreation(time: self.matchsArray[indexPath.section].match.timestamp)
                }
            
            }
            
        return moreCell
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
//
//    @objc func moreButtonTap() {
//        limit += 10
//        DispatchQueue.main.async {
//            self.matchHistory.reloadData()
//        }
//    }
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        footer.moreButton.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
//
//
//       return footer
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 25
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}


// flow: offset - текущий сдвиг по элементам с бека

private func dateFromGameCreation(time: Int) -> String {
    let realTime = round(Double(time/1000))
    let date = Date(timeIntervalSince1970: realTime)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let strDate = dateFormatter.string(from: date)
    return strDate
}

private func imageForItem(item: Int, completion: @escaping (UIImage?) -> ()) {
 var imageURL: URL?
 
DispatchQueue(label: "com.lolproject", qos: .background).async {
     imageURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.10.3216176/img/item/\(item).png")
     guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
     DispatchQueue.main.async {
         completion(UIImage(data: imageData))
     }
 }
}
 
