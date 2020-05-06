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
        let foundSummoner = summoner.first!
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(foundSummoner.profileIconId)).png")
       
       
        
     //   let chammpion = champions.first(where: {$0.key == "67"})
   //     print(chammpion?.name)
        networkAPI.fetchMostPlayedChampions(summonerId: foundSummoner.id) { result in
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
