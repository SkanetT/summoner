//
//  LeagueController.swift
//  LoLProject
//
//  Created by Антон on 02.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class LeagueController: UIViewController {
    
    
    
    var leagueId: String = ""
    
    var rankData: RankData?
    
    var currectTier: [Entry] = []
    var tierOne: [Entry] = []
    var tierTwo: [Entry] = []
    var tierThree: [Entry] = []
    var tierFour: [Entry] = []

    let summoner  = try! Realm().objects(FoundSummoner.self)
    
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rankData = rankData else { return }
        
       
        
        title = rankData.name
        leagueImage.leagueImage(league: rankData.tier)
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        
        
        
        tierOne = rankData.entries.filter({ $0.rank == "I" })
        tierOne.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierTwo = rankData.entries.filter({ $0.rank == "II" })
        tierTwo.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierThree = rankData.entries.filter({ $0.rank == "III" })
        tierThree.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierFour = rankData.entries.filter({ $0.rank == "IV" })
        tierFour.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        
        if let foundSommonerName = summoner.first?.name {
                   if let summonerEntry = rankData.entries.first(where: { $0.summonerName == foundSommonerName }) {
                       switch summonerEntry.rank {
                       case "I":
                           segmentedControl.selectedSegmentIndex = 0
                        currectTier = tierOne
                       case "II":
                           segmentedControl.selectedSegmentIndex = 1
                        currectTier = tierTwo

                       case "III":
                           segmentedControl.selectedSegmentIndex = 2
                        currectTier = tierThree

                       case "IV":
                           segmentedControl.selectedSegmentIndex = 3
                        currectTier = tierFour

                       default:
                           break
                       }
                   }
                   
               }
        
        
        
        
        tableView.reloadData()
    }
    
    @IBAction func changeTier(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            currectTier = tierOne
            tableView.reloadData()
        case 1:
            currectTier = tierTwo
            tableView.reloadData()
        case 2:
            currectTier = tierThree
            tableView.reloadData()
        case 3:
            currectTier = tierFour
            tableView.reloadData()
        default:
            break
        }
    }
    

}

extension LeagueController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return currectTier.count
        return currectTier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        
        guard let foundSommonerName = summoner.first?.name  else { return cell }
        
       
        
        cell.nameLabel.text = currectTier[indexPath.row].summonerName
        cell.lpLabel.text = String(currectTier[indexPath.row].leaguePoints)
        cell.backgroundColor = .white
        
        if foundSommonerName == currectTier[indexPath.row].summonerName {
            cell.backgroundColor = .yellow
        }
        
        return cell
    }
    
    
    
    
}
