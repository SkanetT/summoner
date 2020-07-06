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
    
    func attach(_ output: SummonerInteractorOutput) {
        self.output = output
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
