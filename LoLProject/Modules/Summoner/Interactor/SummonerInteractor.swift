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
    
    let foundSummoner = RealmManager.fetchFoundSummoner()
    let saveSummoner = RealmManager.fetchSaveSummoner()
    
    var data: ((SpectatorData) -> () )?
    
    func attach(_ output: SummonerInteractorOutput) {
        self.output = output
    }
    
    func fetchSaveAndFoundSummoners() {
        guard let saveSummoner = saveSummoner, let foundSummoner = foundSummoner else { return }
        output?.didReceiveSaveAndFoundSummoner(saveSummoner, foundSummoner)
    }
    
    func fetchSpectatorData() {
        guard let foundSummoner = foundSummoner else { return }
        let spectatorRequest = SpectatorRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
        NetworkAPI.shared.dataTask(request: spectatorRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let spectatorDate):
                self.output?.successSpectatorData(spectatorDate)
            
            case.failure(let error):
                self.output?.failureSpectatorData(error)
                
            }
        }
        
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
    
}
