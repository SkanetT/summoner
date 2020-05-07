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
    
    @IBOutlet var flexRang: UILabel!
    @IBOutlet var flexImage: UIImageView!
    @IBOutlet var soloRang: UILabel!
    @IBOutlet var soloImage: UIImageView!
    
    
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
                if let soloRangData = leagueData.first(where: {$0.queueType == "RANKED_SOLO_5x5"}) {
                    
                    DispatchQueue.main.async {
                        self.soloRang.text = soloRangData.tier + " " + soloRangData.rank
                        switch soloRangData.tier {
                        case "BRONZE":
                            self.soloImage.image = #imageLiteral(resourceName: "Untitled 2")
                        case "SILVER":
                            self.soloImage.image = #imageLiteral(resourceName: "Silver")
                        case "GOLD":
                            self.soloImage.image = #imageLiteral(resourceName: "Gold")
                        default:
                            self.soloImage.image = #imageLiteral(resourceName: "Unranked")
                        }
                    }
                }
                if let flexRangData = leagueData.first(where: {$0.queueType == "RANKED_FLEX_SR"}) {
                    DispatchQueue.main.async {
                        self.flexRang.text = flexRangData.tier + " " + flexRangData.rank
                        switch flexRangData.tier {
                        case "BRONZE":
                            self.flexImage.image = #imageLiteral(resourceName: "Untitled 2")
                        case "SILVER":
                            self.flexImage.image = #imageLiteral(resourceName: "Silver")
                        case "GOLD":
                            self.flexImage.image = #imageLiteral(resourceName: "Gold")
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
        let realm = try! Realm()
        let summoner = try! Realm().objects(FoundSummoner.self)
        try! realm.write {
            realm.delete(summoner)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
}
