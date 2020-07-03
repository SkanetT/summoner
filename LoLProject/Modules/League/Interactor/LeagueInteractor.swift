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
    
    init(data: RankData) {
        self.rankData = data
    }
    
    func attach(_ output: LeagueInteractorOutput) {
        self.output = output
    }
    
    func fetchNewTier(_ tier: String) {
        let newTier = rankData.entries.filter{ $0.rank == tier }.sorted(by: { $0.leaguePoints > $1.leaguePoints })
        output?.didReciveNewTier(newTier)
    }
    
    func fetchDataForView() {
        output?.receiveData(rankData)
       }
    
    func fetchFoundSummonerInLeague() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        
        
        if let summonerEntry = rankData.entries.first(where: { $0.summonerName == foundSummoner.name }) {
            
            let summonerTier = UserRank.init(rank: summonerEntry.rank)
            let tier = rankData.entries.filter{ $0.rank == summonerTier.title }.sorted(by: { $0.leaguePoints > $1.leaguePoints })
            
            output?.didReciveTier(tier: tier, rank: summonerTier.title)
            return
            
        }
    }
    
    func attemptToReconnect(summonerName: String) {
        guard let server = RealmManager.fetchFoundSummoner()?.region else { return }
        
        let request = SummonerRequest(summonerName: summonerName, server: server)
        
        NetworkAPI.shared.dataTask(request: request) {[weak self] result in
            switch result {
            case.success(let summonerData):
                DispatchQueue.main.async {
                    RealmManager.reWriteFoundSummoner(summonerData)
                    self?.output?.reconnectSuccess()
                    
                }
                
            case.failure(let error):
                self?.output?.reconnectFailure(error)
            }
        }
    }
}
