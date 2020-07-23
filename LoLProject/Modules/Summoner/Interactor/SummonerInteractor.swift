//
//  SummonerInteractor.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class SummonerInteractor: SummonerInteractorInput {
    
    private weak var output: SummonerInteractorOutput?
    
    let dataQueue: DispatchQueue = DispatchQueue.init(label: "qqq", qos: .userInteractive)
    
    let foundSummoner = RealmManager.fetchFoundSummoner()
    let saveSummoner = RealmManager.fetchSaveSummoner()
    var spectatorData: SpectatorData?
    var matchsArray: [ExpandableMathHistory] = []
    var matchModel: [MatchModel] = []
    var isFirstTimeLoad = true
    
    func attach(_ output: SummonerInteractorOutput) {
        self.output = output
    }
    
    func fetchSaveAndFoundSummoners() {
        guard let saveSummoner = saveSummoner, let foundSummoner = foundSummoner else { return }
        output?.didReceiveSaveAndFoundSummoner(saveSummoner, foundSummoner)
    }
    
    func fetchSaveAndFoundSummonerNames() {
        guard let saveSummoner = saveSummoner, let foundSummoner = foundSummoner else { return }
        output?.didReceiveSaveAndFoundSummonerNames(saveSummoner.name, foundSummoner.name)
    }
    
    func rewriteSave() {
        RealmManager.reWriteSaveSummoner()
        output?.successRewrite()
    }
    
    func fetchLeagueData() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        let leagueRequest = LeagueRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
        
        NetworkAPI.shared.dataTask(request: leagueRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let leagueData):
                self.output?.successLeague(leagueData)
            case.failure(let error):
                self.output?.failureLeague(error)
            }
        }
    }
    
    func fetchSpectatorData() {
        guard let foundSummoner = foundSummoner else { return }
        let spectatorRequest = SpectatorRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
        NetworkAPI.shared.dataTask(request: spectatorRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let spectatorData):
                self.output?.successSpectatorData()
                self.spectatorData = spectatorData
            case.failure(let error):
                self.output?.failureSpectatorData(error)
                
            }
        }
    }
    
    func giveSpectatorData() {
        guard let data = spectatorData else { return }
        output?.didReceiveDataForSpectator(data)
    }
    
    func fetchMostPlayedChampions() {
        guard let foundSummoner = foundSummoner else { return }
        let mostPlayedChampionsRequest = MostPlayedChampionsRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
        
        NetworkAPI.shared.dataTask(request: mostPlayedChampionsRequest) {[weak self] result in
            switch result {
            case .success(let mostPlayedChampions):
                self?.output?.successMostPlayedChampions(mostPlayedChampions)
            case .failure(let error):
                self?.output?.failureMostPlayedChampions(error)
            }
        }
    }
    
    func fetchMatchHistory() {
        guard let foundSummoner = foundSummoner else { return }
        let matchHistoryRequest = MatchHistoryRequest.init(accountId: foundSummoner.accountId, server: foundSummoner.region)
        
        NetworkAPI.shared.dataTask(request: matchHistoryRequest) {[weak self] result in
            
            guard let self = self else{ return }
            switch result {
            case .success(let matchs):
                self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
                self.output?.successMatchHistory()
            case .failure(let error):
                self.output?.failureMatchHistory(error)
            }
        }
    }
    
    func fetchRankData(_ leagueId: String) {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }

        let req = RankRequest(leagueId: leagueId, server: foundSummoner.region)
        
        NetworkAPI.shared.dataTask(request: req) {[weak self] result in
            switch result{
            case.success(let rankData):
                DispatchQueue.main.async {
                    self?.output?.successRank(rankData)
                }
            case .failure(let error):
                self?.output?.failureRank(error)
            }
        }
    }
    
    func fetchMatchs() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        
        let name = foundSummoner.name
        let id = foundSummoner.id
        let server = foundSummoner.region
        let disGroup = DispatchGroup()
        
        let decValue = matchsArray.count - matchModel.count < 7 ? matchsArray.count - matchModel.count - 1 : 7
        guard decValue > 1 else { return }
        
        for i in matchModel.count...(matchModel.count + decValue) {
            disGroup.enter()
            
            let fullInfoMatch = FullInfoMatchRequest.init(matchId: String(self.matchsArray[i].match.gameId), server: server)
            
            NetworkAPI.shared.dataTask(request: fullInfoMatch) {[weak self] result in
                guard let self = self else { return }
                
                switch result {
                case.success(let fullMatchHistory):
                    self.dataQueue.sync(flags:.barrier) {
                        disGroup.leave()
                        let match: MatchModel = .init(match: fullMatchHistory, summonerName: name, summonerId: id, handler: {[weak self] str in
                            
                            self?.relogin(name: str)
                        })
                        self.matchModel.append(match)
                    }
                case.failure:
                    self.reloadMatch(disGroup: disGroup, matchId: self.matchsArray[i].match.gameId, region: server, summonerName: name, summonerId: id)
                }
            }
        }
        
        disGroup.notify(queue: .main) {[weak self] in
            guard let self = self else { return }
            self.matchModel.sort { (lhs, rhs) -> Bool in
                return lhs.summonerInMatch.dateCreation > rhs.summonerInMatch.dateCreation
            }
            
            if self.isFirstTimeLoad {
                self.isFirstTimeLoad = false
                self.output?.didReceiveDataForTable(matchsArray: self.matchsArray, matchModel: self.matchModel)
            } else {
                self.output?.didReceiveUpdateForTable(self.matchModel)
            }
        }
    }
    
    func reloadMatch(disGroup: DispatchGroup, matchId: Int,region: String, reply: Int = 0, summonerName: String, summonerId: String) {
        guard reply < 4 else {
            disGroup.leave()
            return
        }
        let fullInfoMatch = FullInfoMatchRequest.init(matchId: String(matchId), server: region)
        NetworkAPI.shared.dataTask(request: fullInfoMatch) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let fullMatchHistory):
                self.dataQueue.sync(flags:.barrier) {
                    disGroup.leave()
                    let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName, summonerId: summonerId, handler: {[weak self] str in
                        self?.relogin(name: str)
                    })
                    self.matchModel.append(match)
                }
            case.failure:
                self.reloadMatch(disGroup: disGroup, matchId: matchId, region: region, reply: reply + 1, summonerName: summonerName, summonerId: summonerId)
            }
        }
    }
    
    func relogin(name: String) {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        if name != foundSummoner.name {
            
            let server = foundSummoner.region
            let request = SummonerRequest(summonerName: name, server: server)
            NetworkAPI.shared.dataTask(request: request) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let summonerData):
                    DispatchQueue.main.async {
                        RealmManager.reWriteFoundSummoner(summonerData)
                        self.output?.successRelogin()
                    }
                case.failure(let error):
                    self.output?.failureRelogin(error)
                }
            }
        }
    }
}


