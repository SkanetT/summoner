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

    struct MatchModel {
        let matchType: String
        let date: String
        let dateCreation: Int
        let time: String
        var win: Bool = false
        var summonerIdInMatch = 0
        
        var summonerChampionKey: String = ""
        var summonerKda: String = ""
        var summonerSpellKey1: String = ""
        var summonerSpellKey2: String = ""
        var summonerWardId: String = ""
        var summonerFirstItemId: String = ""
        var summonerSecondItemId: String = ""
        var summonerThirdItemId: String = ""
        var summonerFourthItemId: String = ""
        var summonerFifthItemId: String = ""
        var summonerSixthItemId: String = ""
        
        var members: [Member] = []
        
        
        init(match: FullInfoMatch, summonerName: String) {
            
            dateCreation = match.gameCreation
            
            switch match.queueId {
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
            
            date = dateFromGameCreation(time: match.gameCreation)
            time = timeOfMatc(time: match.gameDuration)
            
            if let myPlayerIdentities = match.participantIdentities.first(where: { $0.player.summonerName == summonerName }){
                summonerIdInMatch = myPlayerIdentities.participantId
                if let myPlayer = match.participants.first(where: { $0.participantId == summonerIdInMatch }) {
                    win = myPlayer.stats.win
                    summonerChampionKey = String(myPlayer.championId)
                    summonerKda = "\(myPlayer.stats.kills) / \(myPlayer.stats.deaths) / \(myPlayer.stats.assists)"
                    summonerSpellKey1 = String(myPlayer.spell1Id)
                    summonerSpellKey2 = String(myPlayer.spell2Id)
                    summonerWardId = String(myPlayer.stats.item6)
                    summonerFirstItemId = String(myPlayer.stats.item0)
                    summonerSecondItemId = String(myPlayer.stats.item1)
                    summonerThirdItemId = String(myPlayer.stats.item2)
                    summonerFourthItemId = String(myPlayer.stats.item3)
                    summonerFifthItemId = String(myPlayer.stats.item4)
                    summonerSixthItemId = String(myPlayer.stats.item5)
                }
            }
            
            for id in 1...match.participantIdentities.count {
                if let member = match.participants.first(where: { $0.participantId == id }), let memberIdentities = match.participantIdentities.first(where: { $0.participantId == id }) {
                    
                    var memberData = Member()
                    memberData.name = memberIdentities.player.summonerName
                    memberData.championKey = String(member.championId)
                    memberData.kda = "\(member.stats.kills) / \(member.stats.deaths) / \(member.stats.assists)"
                    memberData.spellKey1 = String(member.spell1Id)
                    memberData.spellKey2 = String(member.spell2Id)
                    memberData.wardId = String(member.stats.item6)
                    memberData.firstItemId = String(member.stats.item0)
                    memberData.secondItemId = String(member.stats.item1)
                    memberData.thirdItemId = String(member.stats.item2)
                    memberData.fourthItemId =  String(member.stats.item3)
                    memberData.fifthItemId = String(member.stats.item4)
                    memberData.sixthItemId = String(member.stats.item5)
                    
                    members.append(memberData)
                    
                }
            }
            
        }
    }
    
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
        
        matchHistory.register(UINib(nibName: "MachHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        matchHistory.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return }
        let summonerName = foundSummoner.name
        
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
        
        let disGroup = DispatchGroup()
        
        
        networkAPI.fetchMatchHistory(accountId: foundSummoner.accountId) {[weak self] result in
            guard let self = self else{ return }
            switch result {
            case .success(let matchs):
                    self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
                    for i in 0...3 {
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
                        print(self.matchModel.count)
                        self.matchModel.sort { (lhs, rhs) -> Bool in
                            return lhs.dateCreation > rhs.dateCreation
                        }
                        
                        self.matchHistory.reloadData()
                    }

            case .failure:
                print("Error matchs")
            }
        }
        
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(foundSummoner.profileIconId)).png")
       
        
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
        matchModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let matchCell = tableView.dequeueReusableCell(withIdentifier: "mach", for: indexPath) as! MachHistoryCell
        let moreCell = tableView.dequeueReusableCell(withIdentifier: "moreInfo", for: indexPath) as! MoreInfoCell
        let championKey = String(self.matchsArray[indexPath.section].match.champion)
        
        let spells = try! Realm().objects(SummonerSpell.self)
        
        let thisMatch = matchModel[indexPath.section]
        
        matchCell.kda.text = thisMatch.summonerKda
        
        matchCell.typeAndWin.text = thisMatch.matchType
        
        if thisMatch.win == true {
            matchCell.typeAndWin.backgroundColor = .green
        } else {
            matchCell.typeAndWin.backgroundColor = .red

        }
        
        matchCell.dateAndTime.text = "\(thisMatch.date) \(thisMatch.time) "
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerFirstItemId) { icon in
            matchCell.item0.image = icon
        }
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerSecondItemId) { icon in
            matchCell.item1.image = icon
        }
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerThirdItemId) { icon in
            matchCell.item2.image = icon
        }
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerFourthItemId) { icon in
            matchCell.item3.image = icon
        }
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerFifthItemId) { icon in
            matchCell.item4.image = icon
        }
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerSixthItemId) { icon in
            matchCell.item5.image = icon
        }
        
        networkAPI.fetchImageToItem(itemId: thisMatch.summonerWardId) { icon in
            matchCell.item6.image = icon
        }
        
        if let spell1 = spells.first(where: { $0.key == thisMatch.summonerSpellKey1 }), let spell2 = spells.first(where: { $0.key == thisMatch.summonerSpellKey2 }){
            networkAPI.fetchImageToSummonerSpell(spellId: spell1.id) { icon in
                matchCell.Spell1.image = icon
            }
            networkAPI.fetchImageToSummonerSpell(spellId: spell2.id) { icon in
                matchCell.Spell2.image = icon
            }
        }
        
        if thisMatch.members.count == 10 {
            switch thisMatch.summonerIdInMatch {
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
            
            if thisMatch.win == true {
                if thisMatch.summonerIdInMatch <= 5 {
                    moreCell.team1.backgroundColor = .green
                    moreCell.team1Win.text = "Win"
                    moreCell.team2.backgroundColor = .red
                    moreCell.team2Win.text = "Defeat"
                } else {
                    moreCell.team1.backgroundColor = .red
                    moreCell.team1Win.text = "Defeat"
                    moreCell.team2.backgroundColor = .green
                    moreCell.team2Win.text = "Win"
                }
            } else {
                if thisMatch.summonerIdInMatch <= 5 {
                    moreCell.team1.backgroundColor = .red
                    moreCell.team1Win.text = "Defeat"
                    moreCell.team2.backgroundColor = .green
                    moreCell.team2Win.text = "Win"
                } else {
                    moreCell.team1.backgroundColor = .green
                    moreCell.team1Win.text = "Win"
                    moreCell.team2.backgroundColor = .red
                    moreCell.team2Win.text = "Defeat"
                }
            }
            
            moreCell.participant1.setData(member: thisMatch.members[0])
            moreCell.participant2.setData(member: thisMatch.members[1])
            moreCell.participant3.setData(member: thisMatch.members[2])
            moreCell.participant4.setData(member: thisMatch.members[3])
            moreCell.participant5.setData(member: thisMatch.members[4])
            moreCell.participant6.setData(member: thisMatch.members[5])
            moreCell.participant7.setData(member: thisMatch.members[6])
            moreCell.participant8.setData(member: thisMatch.members[7])
            moreCell.participant9.setData(member: thisMatch.members[8])
            moreCell.participant10.setData(member: thisMatch.members[9])


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
        
        
    }
}

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

private func timeOfMatc(time: Int) -> String {
    let timeMatch = time / 60
    let timeMatchSec = time % 60
    var result: String = ""
    if timeMatchSec < 10 {
        result = "\(timeMatch):0\(timeMatchSec)"
    } else {
        result = "\(timeMatch):\(timeMatchSec)"
    }
    return result
}

private func imageForItem(item: Int, completion: @escaping (UIImage?) -> ()) {
 var imageURL: URL?
 
DispatchQueue(label: "com.lolproject", qos: .background).async {
     imageURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.10.3216176/img/item/\(item).png")
     guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
     DispatchQueue.main.async {
        if url == imageURL {
            completion(UIImage(data: imageData))
        }
     }
  }
}
 
