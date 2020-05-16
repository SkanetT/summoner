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
    
    @IBOutlet var firstMostPlayedChampionImage: UIImageView!
    @IBOutlet var firstMostPlayedChampionNameLvl: UILabel!
    @IBOutlet var firstMostPlayedChampionPts: UILabel!
    @IBOutlet var secondMostPlayedChampionImage: UIImageView!
    @IBOutlet var secondMostPlayedChampionNameLvl: UILabel!
    @IBOutlet var secondMostPlayedChampionPts: UILabel!
    @IBOutlet var thidMostPlayedChampionImage: UIImageView!
    @IBOutlet var thidMostPlayedChampionNameLvl: UILabel!
    @IBOutlet var thidMostPlayedChampionPts: UILabel!
    
    
    @IBOutlet var machHistory: UITableView!
    
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
        
        machHistory.delegate = self
        machHistory.dataSource = self
        
        
        machHistory.register(UINib(nibName: "MachHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        
        
        
        
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
