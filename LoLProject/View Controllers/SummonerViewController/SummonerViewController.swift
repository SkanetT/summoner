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
                            
                            
                            switch myIdInGame {
                            case 1:
                                moreCell.participant1.thisView.backgroundColor = .yellow
                            case 2:
                                moreCell.participant2.thisView.backgroundColor = .yellow
                            case 3:
                                moreCell.participant3.thisView.backgroundColor = .yellow
                            case 4:
                                moreCell.participant4.thisView.backgroundColor = .yellow
                            case 5:
                                moreCell.participant5.thisView.backgroundColor = .yellow
                            case 6:
                                moreCell.participant6.thisView.backgroundColor = .yellow
                            case 7:
                                moreCell.participant7.thisView.backgroundColor = .yellow
                            case 8:
                                moreCell.participant8.thisView.backgroundColor = .yellow
                            case 9:
                                moreCell.participant9.thisView.backgroundColor = .yellow
                            case 10:
                                moreCell.participant10.thisView.backgroundColor = .yellow
                            default:
                                print()
                            }
                            
                            if let participant1 = fullInfoMatch.participants.first(where: {$0.participantId == 1}), let participant1Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 1}) {
                                let participant1Name = participant1Identities.player.summonerName
                                moreCell.participant1.setData(participant: participant1, participantName: participant1Name)
                                if participant1.stats.win == true {
                                    moreCell.team1.backgroundColor = .green
                                    moreCell.team1Win.textColor = .green
                                    moreCell.team2.backgroundColor = .red
                                    moreCell.team2Win.textColor = .red
                                    moreCell.team1Win.text = "Win"
                                    moreCell.team2Win.text = "Defeat"
                                } else {
                                    moreCell.team1.backgroundColor = .red
                                    moreCell.team1Win.textColor = .red
                                    moreCell.team2.backgroundColor = .green
                                    moreCell.team2Win.textColor = .green
                                    moreCell.team1Win.text = "Defeat"
                                    moreCell.team2Win.text = "Win"
                                }
                                
                            }
                            
                            if let participant2 = fullInfoMatch.participants.first(where: {$0.participantId == 2}), let participant2Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 2}) {
                                let participant2Name = participant2Identities.player.summonerName
                                moreCell.participant2.setData(participant: participant2, participantName: participant2Name)
                                
                            }
                            
                            if let participant3 = fullInfoMatch.participants.first(where: {$0.participantId == 3}), let participant3Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 3}) {
                                let participant3Name = participant3Identities.player.summonerName
                                moreCell.participant3.setData(participant: participant3, participantName: participant3Name)
                                
                            }
                            
                            if let participant4 = fullInfoMatch.participants.first(where: {$0.participantId == 4}), let participant4Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 4}) {
                                let participant4Name = participant4Identities.player.summonerName
                                moreCell.participant4.setData(participant: participant4, participantName: participant4Name)
                                
                            }
                            
                            if let participant5 = fullInfoMatch.participants.first(where: {$0.participantId == 5}), let participant5Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 5}) {
                                let participant5Name = participant5Identities.player.summonerName
                                moreCell.participant5.setData(participant: participant5, participantName: participant5Name)
                                
                            }
                            
                            if let participant6 = fullInfoMatch.participants.first(where: {$0.participantId == 6}), let participant6Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 6}) {
                                let participant6Name = participant6Identities.player.summonerName
                                moreCell.participant6.setData(participant: participant6, participantName: participant6Name)
                                
                            }
                            
                            if let participant7 = fullInfoMatch.participants.first(where: {$0.participantId == 7}), let participant7Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 7}) {
                                let participant7Name = participant7Identities.player.summonerName
                                moreCell.participant7.setData(participant: participant7, participantName: participant7Name)
                                
                            }
                            
                            if let participant8 = fullInfoMatch.participants.first(where: {$0.participantId == 8}), let participant8Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 8}) {
                                let participant8Name = participant8Identities.player.summonerName   
                                moreCell.participant8.setData(participant: participant8, participantName: participant8Name)
                                
                            }
                            
                            if let participant9 = fullInfoMatch.participants.first(where: {$0.participantId == 9}), let participant9Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 9}) {
                                let participant9Name = participant9Identities.player.summonerName
                                moreCell.participant9.setData(participant: participant9, participantName: participant9Name)
                                
                            }
                            
                            if let participant10 = fullInfoMatch.participants.first(where: {$0.participantId == 10}), let participant10Identities = fullInfoMatch.participantIdentities.first(where: {$0.participantId == 10}) {
                                let participant10Name = participant10Identities.player.summonerName
                                moreCell.participant10.setData(participant: participant10, participantName: participant10Name)
                                
                            }
                            
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
                            
                            var matchType = "Type"
                            switch fullInfoMatch.queueId {
                            case 400:
                                matchType = "Normal (Draft Pick)"
                            case 420:
                                matchType = "Ranked Solo/Duo"
                            case 430:
                                matchType = "Normal (Blind Pick)"
                            case 440:
                                matchType = "Ranked Flex"
                            default:
                                matchType = "Error type"
                            }
                            
                            
                            let timeMatch = fullInfoMatch.gameDuration / 60
                            let timeMatchSec = fullInfoMatch.gameDuration % 60
                            matchCell.typeAndWin.text = "\(matchType)"
                            if timeMatchSec < 10 {
                                matchCell.dateAndTime.text = "\(dateFromGameCreation(time: fullInfoMatch.gameCreation)) \(timeMatch):0\(timeMatchSec)"
                            } else {
                                matchCell.dateAndTime.text = "\(dateFromGameCreation(time: fullInfoMatch.gameCreation)) \(timeMatch):\(timeMatchSec)"
                            }
                            matchCell.kda.text = "\(myPlayer.stats.kills) / \(myPlayer.stats.deaths) / \(myPlayer.stats.assists)"
                            if myPlayer.stats.win == true {
                                matchCell.winOrLose.alpha = 0.75
                                matchCell.winOrLose.backgroundColor = .green
                            } else {
                                matchCell.winOrLose.alpha = 0.75
                                matchCell.winOrLose.backgroundColor = .red
                            }
                        }
                    }
                }
                
            case .failure:
                
                print("No full info for \(indexPath.section), matchID \(matchId)")
            }
        }
        
        
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                matchCell.tapHandler = { [weak self]  in
                    self?.matchsArray[indexPath.section].isExpanded.toggle()
                    self?.matchHistory.reloadSections([indexPath.section], with: .fade)
                    
                }
                
                if let champion = self.champions.first(where: {$0.key == championKey}) {
                
                    self.networkAPI.fetchImageToChampionIcon(championId: champion.id) { icon in
                        matchCell.championIcon.image = icon
                    
                    }
                }
            }
            return matchCell
        } else {
            DispatchQueue.main.async {
            moreCell.tapHandler = { [weak self]  in
                self?.matchsArray[indexPath.section].isExpanded.toggle()
                self?.matchHistory.reloadSections([indexPath.section], with: .fade)
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
 
