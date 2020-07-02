//
//  LeagueInteractor.swift
//  LoLProject
//
//  Created by Антон on 01.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LeagueInteractor: LeagueInteractorInput {
    
    
    
    var rankData: RankData
    private weak var output: LeagueInteractorOutput?
//    var foundSummoner = RealmManager.fetchFoundSummoner()
    var currectTier: [Entry] = []
    var tierOne: [Entry] = []
    var tierTwo: [Entry] = []
    var tierThree: [Entry] = []
    var tierFour: [Entry] = []
    
    init(data: RankData) {
        self.rankData = data
    }
    
    func attach(_ output: LeagueInteractorOutput) {
        self.output = output
    }
    
    func filterByTiers() {
        tierOne = rankData.entries.filter({ $0.rank == "I" })
        tierOne.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierTwo = rankData.entries.filter({ $0.rank == "II" })
        tierTwo.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierThree = rankData.entries.filter({ $0.rank == "III" })
        tierThree.sort(by: { $0.leaguePoints > $1.leaguePoints })
        
        tierFour = rankData.entries.filter({ $0.rank == "IV" })
        tierFour.sort(by: { $0.leaguePoints > $1.leaguePoints })
    }
    
    func fetchFoundSummonerInLeague() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
    
        
        if let summonerEntry = rankData.entries.first(where: { $0.summonerName == foundSummoner.name }) {
            
            let summonerTier = UserRank.init(rank: summonerEntry.rank)
            let tier = rankData.entries.filter{ $0.rank == summonerTier.title }.sorted(by: { $0.leaguePoints > $1.leaguePoints })
            
            
            output?.didReciveTier(tier: tier, rank: summonerTier.title)
            return
//
//            switch summonerEntry.rank {
//            case "I":
//                //   segmentedControl.selectedSegmentIndex = 0
//                tierOne = tierOne.filter({ $0.summonerName != foundSummoner.name })
//                tierOne.insert(summonerEntry, at: 0)
//                currectTier = tierOne
//                output?.didReciveTier(tier: currectTier, rank: "I")
//            case "II":
//                //     segmentedControl.selectedSegmentIndex = 1
//                tierTwo = tierTwo.filter({ $0.summonerName != foundSummoner.name })
//                tierTwo.insert(summonerEntry, at: 0)
//                currectTier = tierTwo
//                output?.didReciveTier(tier: currectTier, rank: "II")
//
//
//            case "III":
//                //   segmentedControl.selectedSegmentIndex = 2
//                tierThree = tierThree.filter({ $0.summonerName != foundSummoner.name })
//                tierThree.insert(summonerEntry, at: 0)
//                currectTier = tierThree
//                output?.didReciveTier(tier: currectTier, rank: "III")
//
//
//            case "IV":
//                //        segmentedControl.selectedSegmentIndex = 3
//                tierFour = tierFour.filter({ $0.summonerName != foundSummoner.name })
//                tierFour.insert(summonerEntry, at: 0)
//                currectTier = tierFour
//                output?.didReciveTier(tier: currectTier, rank: "IV")
//
//
//            default:
//                break
//            }
        }
        
    }
    
}
