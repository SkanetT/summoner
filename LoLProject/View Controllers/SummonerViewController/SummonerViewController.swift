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
    
    @IBOutlet var summonerIconImage: UIImageView!
    @IBOutlet var nameLebel: UILabel!
    @IBOutlet var lvlLabel: UILabel!
    
    @IBOutlet var firstMostPlayedChampionImage: UIImageView!
    @IBOutlet var firstmostPlayedChampionNameLvl: UILabel!
    @IBOutlet var firstMostPlayedChampionPts: UILabel!
    @IBOutlet var secondMostPlayedChampionImage: UIImageView!
    @IBOutlet var secondMostPlayedChampionNameLvl: UILabel!
    @IBOutlet var secondMostPlayedChampionPts: UILabel!
    @IBOutlet var thidMostPlayedChampionImage: UIImageView!
    @IBOutlet var thidMostPlayedChampionNameLvl: UILabel!
    @IBOutlet var thidMostPlayedChampionPts: UILabel!
    
    @IBOutlet var flexRank: UILabel!
    @IBOutlet var flexImage: UIImageView!
    @IBOutlet var flexWr: UILabel!
    @IBOutlet var soloRank: UILabel!
    @IBOutlet var soloImage: UIImageView!
    @IBOutlet var soloWr: UILabel!
    
    
    let networkAPI = NetworkAPI()
    
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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return }
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(foundSummoner.profileIconId)).png")
       
       
        networkAPI.fetchLeagues(summonerId: foundSummoner.id) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let leagueData):
                if let soloRankData = leagueData.first(where: {$0.queueType == "RANKED_SOLO_5x5"}) {
                    let wrSolo :Double
                    wrSolo = Double(soloRankData.wins) / (Double(soloRankData.wins) + Double(soloRankData.losses)) * 100
                    
                    DispatchQueue.main.async {
                        self.soloRank.text = "\(soloRankData.tier) \(soloRankData.rank) (LP \(soloRankData.leaguePoints))"
                        if wrSolo < 50 {
                            self.soloWr.textColor = .red
                        } else {
                            self.soloWr.textColor = .green
                        }
                        self.soloWr.text = "WR \(round(10*wrSolo)/10)%"
                        switch soloRankData.tier {
                        case "IRON":
                            self.soloImage.image = #imageLiteral(resourceName: "Iron")
                        case "BRONZE":
                            self.soloImage.image = #imageLiteral(resourceName: "Bronze")
                        case "SILVER":
                            self.soloImage.image = #imageLiteral(resourceName: "Silver")
                        case "GOLD":
                            self.soloImage.image = #imageLiteral(resourceName: "Gold")
                        case "PLATINUM":
                            self.soloImage.image = #imageLiteral(resourceName: "Platinum")
                        case "DIAMOND":
                            self.soloImage.image = #imageLiteral(resourceName: "Diamond")
                        case "CHALLENGER":
                            self.soloImage.image = #imageLiteral(resourceName: "Challenger")
                        case "MASTER":
                            self.soloImage.image = #imageLiteral(resourceName: "Master")
                        case "GRANDMASTER":
                            self.soloImage.image = #imageLiteral(resourceName: "Grandmaster")
                        default:
                            self.soloImage.image = #imageLiteral(resourceName: "Unranked")
                        }
                    }
                }
                if let flexRankData = leagueData.first(where: {$0.queueType == "RANKED_FLEX_SR"}) {
                    let wrFlex :Double
                    wrFlex = Double(flexRankData.wins) / (Double(flexRankData.wins) + Double(flexRankData.losses)) * 100
                    DispatchQueue.main.async {
                        self.flexRank.text = "\(flexRankData.tier) \(flexRankData.rank) (LP \(flexRankData.leaguePoints))"
                        if wrFlex < 50 {
                            self.flexWr.textColor = .red
                        } else {
                            self.flexWr.textColor = .green
                        }
                        self.flexWr.text = "WR \(round(10*wrFlex)/10)%"
                        switch flexRankData.tier {
                        case "IRON":
                            self.flexImage.image = #imageLiteral(resourceName: "Iron")
                        case "BRONZE":
                            self.flexImage.image = #imageLiteral(resourceName: "Bronze")
                        case "SILVER":
                            self.flexImage.image = #imageLiteral(resourceName: "Silver")
                        case "GOLD":
                            self.flexImage.image = #imageLiteral(resourceName: "Gold")
                        case "PLATINUM":
                            self.flexImage.image = #imageLiteral(resourceName: "Platinum")
                        case "DIAMOND":
                            self.flexImage.image = #imageLiteral(resourceName: "Diamond")
                        case "CHALLENGER":
                            self.flexImage.image = #imageLiteral(resourceName: "Challenger")
                        case "MASTER":
                            self.flexImage.image = #imageLiteral(resourceName: "Master")
                        case "GRANDMASTER":
                            self.soloImage.image = #imageLiteral(resourceName: "Grandmaster")
                        default:
                            self.flexImage.image = #imageLiteral(resourceName: "Unranked")
                        }
                    }
                }
            case .failure:
                print("no league")
            }
        }
        
        networkAPI.fetchMostPlayedChampions(summonerId: foundSummoner.id) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let mostPlayedChampions):
                DispatchQueue.main.async {
                    let champions = try! Realm().objects(Champion.self)
                    if mostPlayedChampions.count >= 3 {
                        if let firstChampion = champions.first(where: {$0.key == "\(mostPlayedChampions[0].championId)"}), let secondChampion = champions.first(where: {$0.key == "\(mostPlayedChampions[1].championId)"}), let thidChampion = champions.first(where: {$0.key == "\(mostPlayedChampions[2].championId)"}) {
                            self.firstmostPlayedChampionNameLvl.text = firstChampion.name + " " + String(mostPlayedChampions[0].championLevel) + " lvl"
                            self.firstMostPlayedChampionPts.text = "pts " + String(mostPlayedChampions[0].championPoints)
                            self.networkAPI.fetchImageToChampionIcon(championId: firstChampion.id) { image in
                                self.firstMostPlayedChampionImage.image = image
                            }
                            
                            self.secondMostPlayedChampionNameLvl.text = secondChampion.name + " " + String(mostPlayedChampions[1].championLevel) + " lvl"
                            self.secondMostPlayedChampionPts.text = "pts " + String(mostPlayedChampions[1].championPoints)
                            self.networkAPI.fetchImageToChampionIcon(championId: secondChampion.id) { image in
                                self.secondMostPlayedChampionImage.image = image
                            }
                                
                            self.thidMostPlayedChampionNameLvl.text = thidChampion.name + " " + String(mostPlayedChampions[2].championLevel) + " lvl"
                            self.thidMostPlayedChampionPts.text = "pts " + String(mostPlayedChampions[2].championPoints)
                            self.networkAPI.fetchImageToChampionIcon(championId: thidChampion.id) { image in
                                self.thidMostPlayedChampionImage.image = image
                            }
                        }
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
