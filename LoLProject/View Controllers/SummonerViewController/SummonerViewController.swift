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
    
    
    @IBOutlet var machHistoryLabel: UITableView!
    
    let networkAPI = NetworkAPI()

    let header = RankView()
    
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
        
        machHistoryLabel.delegate = self
        machHistoryLabel.dataSource = self
        
        
        machHistoryLabel.register(UINib(nibName: "MachHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        
        
        
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return }
        nameLebel.text = foundSummoner.name
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(foundSummoner.profileIconId)).png")
       
       
        
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

extension SummonerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mach", for: indexPath) as! MachHistoryCell
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return nil }
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
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 260
    }
    
    
    
    
    
}
