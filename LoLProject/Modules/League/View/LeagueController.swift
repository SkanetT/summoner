//
//  LeagueController.swift
//  LoLProject
//
//  Created by Антон on 02.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueController: UIViewController {
    
    var rankData: RankData?
    var tableHandler: LeagueTableHandlerProtocol?
    
    var currectTier: [Entry] = []
    var tierOne: [Entry] = []
    var tierTwo: [Entry] = []
    var tierThree: [Entry] = []
    var tierFour: [Entry] = []
    
    let foundSummoner = RealmManager.fetchFoundSummoner()
    
    var presenter: LeaguePresenterInput?
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        segmentedControl.removeAllSegments()
        UserRank.allCases.forEach{
            segmentedControl.insertSegment(withTitle: $0.title, at: segmentedControl.numberOfSegments, animated: false)
        }
        
        segmentedControl.addTarget(self, action: #selector(didChangeUserTier(_:)), for: .valueChanged)
        
        guard let rankData = rankData else { return }
        
        presenter?.attach(self)
        tableHandler?.attach(tableView)
        presenter?.viewDidLoad()
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        title = rankData.name
        leagueImage.leagueImage(league: rankData.tier)
        
        if rankData.tier == "GRANDMASTER" || rankData.tier == "MASTER" || rankData.tier == "CHALLENGER" {
            segmentedControl.isHidden = true
        }
        
        //    tableView.delegate = self
        //   tableView.dataSource = self
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        tableView.remembersLastFocusedIndexPath = true
        tableView.allowsSelection = true
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        
        tierOne = rankData.entries.filter({ $0.rank == "I" })
        tierOne.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierTwo = rankData.entries.filter({ $0.rank == "II" })
        tierTwo.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierThree = rankData.entries.filter({ $0.rank == "III" })
        tierThree.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierFour = rankData.entries.filter({ $0.rank == "IV" })
        tierFour.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        //        if let foundSommonerName = foundSummoner?.name {
        //            if let summonerEntry = rankData.entries.first(where: { $0.summonerName == foundSommonerName }) {
        //                switch summonerEntry.rank {
        //                case "I":
        //                    segmentedControl.selectedSegmentIndex = 0
        //                    tierOne = tierOne.filter({ $0.summonerName != foundSommonerName })
        //                    tierOne.insert(summonerEntry, at: 0)
        //                    currectTier = tierOne
        //                case "II":
        //                    segmentedControl.selectedSegmentIndex = 1
        //                    tierTwo = tierTwo.filter({ $0.summonerName != foundSommonerName })
        //                    tierTwo.insert(summonerEntry, at: 0)
        //                    currectTier = tierTwo
        //
        //                case "III":
        //                    segmentedControl.selectedSegmentIndex = 2
        //                    tierThree = tierThree.filter({ $0.summonerName != foundSommonerName })
        //                    tierThree.insert(summonerEntry, at: 0)
        //                    currectTier = tierThree
        //
        //                case "IV":
        //                    segmentedControl.selectedSegmentIndex = 3
        //                    tierFour = tierFour.filter({ $0.summonerName != foundSommonerName })
        //                    tierFour.insert(summonerEntry, at: 0)
        //                    currectTier = tierFour
        //
        //                default:
        //                    break
        //                }
        //            }
        //        }
        //  tableView.reloadData()
    }
    
    //    @IBAction func changeTier(_ sender: UISegmentedControl) {
    //
    //        switch sender.selectedSegmentIndex {
    //        case 0:
    //            currectTier = tierOne
    //            tableView.reloadData()
    //            tableView.scrollToRow(at: [0,0], at: .bottom, animated: false)
    //        case 1:
    //            currectTier = tierTwo
    //            tableView.reloadData()
    //            tableView.scrollToRow(at: [0,0], at: .bottom, animated: false)
    //
    //        case 2:
    //            currectTier = tierThree
    //            tableView.reloadData()
    //            tableView.scrollToRow(at: [0,0], at: .bottom, animated: false)
    //
    //        case 3:
    //            currectTier = tierFour
    //            tableView.reloadData()
    //            tableView.scrollToRow(at: [0,0], at: .bottom, animated: false)
    //
    //        default:
    //            break
    //        }
    //    }
    
    @objc
    private func didChangeUserTier( _ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        // prese
    }
}

//extension LeagueController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currectTier.count + 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
//
//        guard let foundSommonerName = foundSummoner?.name  else { return cell }
//
//        cell.clipsToBounds = true
//        cell.layer.cornerRadius = 10
//        cell.layer.borderWidth = 0.5
//        cell.layer.borderColor = UIColor.black.cgColor
//
//        if indexPath.row == 0 {
//            cell.backgroundColor = .gray
//            cell.nameLabel.text = "Summoner"
//            cell.winLabel.text = "Wins"
//            cell.lpLabel.text = "Points"
//        } else {
//
//            cell.selectionStyle = .none
//            cell.nameLabel.text = currectTier[indexPath.row - 1].summonerName
//            cell.lpLabel.text = currectTier[indexPath.row - 1].leaguePoints.description
//            cell.winLabel.text = currectTier[indexPath.row - 1].wins.description
//            cell.backgroundColor = .white
//
//            if foundSommonerName == currectTier[indexPath.row - 1].summonerName {
//                cell.backgroundColor = .yellow
//            }
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard indexPath.row != 0, let foundSummoner = self.foundSummoner else { return }
//        guard currectTier[indexPath.row - 1].summonerId != foundSummoner.id else { return }
//
//        let server = foundSummoner.region
//
//        let request = SummonerRequest(summonerName: currectTier[indexPath.row - 1].summonerName, server: server)
//
//        NetworkAPI.shared.dataTask(request: request) {result in
//            switch result {
//            case.success(let summonerData):
//                DispatchQueue.main.async {
//                    RealmManager.reWriteFoundSummoner(summonerData)
//
//                    self.dismiss(animated: true, completion: nil)
//                }
//
//            case.failure(let error):
//                print(error)
//            }
//        }
//    }
//}

extension LeagueController: LeaguePresenterOutput {
    
    func setAction(userSelect: ((Entry) -> ())?) {
        tableHandler?.setAction(userSelect: userSelect)
    }
    
    
    func didReciveUserRank(_ rank: UserRank) {
        segmentedControl.selectedSegmentIndex = rank.rawValue
    }
    
    func didReciveTier(tier: [Entry]) {
        tableHandler?.updateData(tier: tier)
//        switch rank {
//        case "I":
//            segmentedControl.selectedSegmentIndex = 0
//
//        case "II":
//            segmentedControl.selectedSegmentIndex = 1
//            tableHandler?.updateData(tier: tier)
//        case "III":
//            segmentedControl.selectedSegmentIndex = 2
//            tableHandler?.updateData(tier: tier)
//        case "IV":
//            segmentedControl.selectedSegmentIndex = 3
//            tableHandler?.updateData(tier: tier)
//        default:
//            break
//        }
    }
    
    
}
