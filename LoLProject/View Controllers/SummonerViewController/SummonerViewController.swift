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
    
    let header: UIView? = {
        let view = UIView()
        view.backgroundColor = .darkGray
      
        let flexName = UILabel()
        flexName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flexName)
        
        flexName.font = UIFont(name: "Avenir-Heavy", size: 22)
        flexName.textAlignment = .center
        flexName.text = "Flex"
        flexName.textColor = .systemYellow
        flexName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        flexName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100).isActive = true
        flexName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        flexName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let soloName = UILabel()
        soloName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soloName)
        
        soloName.font = UIFont(name: "Avenir-Heavy", size: 22)
        soloName.textAlignment = .center
        soloName.text = "Solo"
        soloName.textColor = .systemYellow
        soloName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        soloName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100).isActive = true
        soloName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        soloName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let networkAPI = NetworkAPI()
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return nil }
        
        let flexRank = UILabel()
        flexRank.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flexRank)
        
        flexRank.font = UIFont(name: "Avenir", size: 17)
        flexRank.textAlignment = .center
        flexRank.text = "Unranked"
        flexRank.textColor = .black
        flexRank.topAnchor.constraint(equalTo: flexName.bottomAnchor, constant: 8).isActive = true
        flexRank.centerXAnchor.constraint(equalTo: flexName.centerXAnchor, constant: 0).isActive = true
        flexRank.widthAnchor.constraint(equalToConstant: 150).isActive = true
        flexRank.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let soloRank = UILabel()
        soloRank.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soloRank)
        
        soloRank.font = UIFont(name: "Avenir", size: 17)
        soloRank.textAlignment = .center
        soloRank.text = "Unranked"
        soloRank.textColor = .black
        soloRank.topAnchor.constraint(equalTo: soloName.bottomAnchor, constant: 8).isActive = true
        soloRank.centerXAnchor.constraint(equalTo: soloName.centerXAnchor, constant: 0).isActive = true
        soloRank.widthAnchor.constraint(equalToConstant: 150).isActive = true
        soloRank.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let flexImage = UIImageView()
        flexImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flexImage)
        
        flexImage.image = #imageLiteral(resourceName: "Unranked")
        flexImage.contentMode = .scaleAspectFit
        flexImage.topAnchor.constraint(equalTo: flexRank.bottomAnchor, constant: 8).isActive = true
        flexImage.centerXAnchor.constraint(equalTo: flexRank.centerXAnchor, constant: 0).isActive = true
        flexImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        flexImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let soloImage = UIImageView()
        soloImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soloImage)
        
        soloImage.image = #imageLiteral(resourceName: "Unranked")
        soloImage.contentMode = .scaleAspectFit
        soloImage.topAnchor.constraint(equalTo: soloRank.bottomAnchor, constant: 8).isActive = true
        soloImage.centerXAnchor.constraint(equalTo: soloRank.centerXAnchor, constant: 0).isActive = true
        soloImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        soloImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let flexWr = UILabel()
        flexWr.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flexWr)
        
        flexWr.font = UIFont(name: "Avenir", size: 17)
        flexWr.textAlignment = .center
        flexWr.text = ""
        flexWr.textColor = .black
        flexWr.topAnchor.constraint(equalTo: flexImage.bottomAnchor, constant: 8).isActive = true
        flexWr.centerXAnchor.constraint(equalTo: flexImage.centerXAnchor, constant: 0).isActive = true
        flexWr.widthAnchor.constraint(equalToConstant: 90).isActive = true
        flexWr.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let soloWr = UILabel()
        soloWr.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(soloWr)
        
        soloWr.font = UIFont(name: "Avenir", size: 17)
        soloWr.textAlignment = .center
        soloWr.text = ""
        soloWr.textColor = .black
        soloWr.topAnchor.constraint(equalTo: soloImage.bottomAnchor, constant: 8).isActive = true
        soloWr.centerXAnchor.constraint(equalTo: soloImage.centerXAnchor, constant: 0).isActive = true
        soloWr.widthAnchor.constraint(equalToConstant: 90).isActive = true
        soloWr.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        
        
        networkAPI.fetchLeagues(summonerId: foundSummoner.id) {result in
      //  guard let self = self else { return }
        switch result {
        case .success(let leagueData):
            if let flexRankData = leagueData.first(where: {$0.queueType == "RANKED_FLEX_SR"}) {
                let wrFlex :Double
                wrFlex = Double(flexRankData.wins) / (Double(flexRankData.wins) + Double(flexRankData.losses)) * 100
                DispatchQueue.main.async {
                    flexRank.text = "\(flexRankData.tier) \(flexRankData.rank) (LP \(flexRankData.leaguePoints))"
                    if wrFlex < 50 {
                        flexWr.textColor = .red
                    } else {
                        flexWr.textColor = .green
                    }
                    flexWr.text = "WR \(round(10*wrFlex)/10)%"
                    switch flexRankData.tier {
                    case "IRON":
                        flexImage.image = #imageLiteral(resourceName: "Iron")
                    case "BRONZE":
                        flexImage.image = #imageLiteral(resourceName: "Bronze")
                    case "SILVER":
                        flexImage.image = #imageLiteral(resourceName: "Silver")
                    case "GOLD":
                        flexImage.image = #imageLiteral(resourceName: "Gold")
                    case "PLATINUM":
                        flexImage.image = #imageLiteral(resourceName: "Platinum")
                    case "DIAMOND":
                        flexImage.image = #imageLiteral(resourceName: "Diamond")
                    case "CHALLENGER":
                        flexImage.image = #imageLiteral(resourceName: "Challenger")
                    case "MASTER":
                        flexImage.image = #imageLiteral(resourceName: "Master")
                    case "GRANDMASTER":
                        soloImage.image = #imageLiteral(resourceName: "Grandmaster")
                    default:
                        flexImage.image = #imageLiteral(resourceName: "Unranked")
                    }
                }
                if let soloRankData = leagueData.first(where: {$0.queueType == "RANKED_SOLO_5x5"}) {
                    let wrSolo :Double
                    wrSolo = Double(soloRankData.wins) / (Double(soloRankData.wins) + Double(soloRankData.losses)) * 100
                    DispatchQueue.main.async {
                        if wrSolo < 50 {
                            soloWr.textColor = .red
                        } else {
                            soloWr.textColor = .green
                        }
                        soloWr.text = "WR \(round(10*wrSolo)/10)%"
                        soloRank.text = "\(soloRankData.tier) \(soloRankData.rank) (LP \(soloRankData.leaguePoints))"
                        switch soloRankData.tier {
                        case "IRON":
                            soloImage.image = #imageLiteral(resourceName: "Iron")
                        case "BRONZE":
                            soloImage.image = #imageLiteral(resourceName: "Bronze")
                        case "SILVER":
                            soloImage.image = #imageLiteral(resourceName: "Silver")
                        case "GOLD":
                            soloImage.image = #imageLiteral(resourceName: "Gold")
                        case "PLATINUM":
                            soloImage.image = #imageLiteral(resourceName: "Platinum")
                        case "DIAMOND":
                            soloImage.image = #imageLiteral(resourceName: "Diamond")
                        case "CHALLENGER":
                            soloImage.image = #imageLiteral(resourceName: "Challenger")
                        case "MASTER":
                            soloImage.image = #imageLiteral(resourceName: "Master")
                        case "GRANDMASTER":
                            soloImage.image = #imageLiteral(resourceName: "Grandmaster")
                        default:
                            soloImage.image = #imageLiteral(resourceName: "Unranked")
                        }
                    }
                }
            }
        case .failure:
            print("no league")
            }
        }
        return view
    } ()
    
    
    
    
    
    
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
        
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 260
    }
    
    
    
    
    
}
