//
//  SpectatorInteractor.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class SpectatorInteractor: SpectatorInteractorInput {
    
    var spectatorDate: SpectatorDate
    
    private weak var output: SpectatorInteractorOutput?
    
    init(_ data: SpectatorDate) {
        self.spectatorDate = data
    }
    
    func attach(_ output: SpectatorInteractorOutput) {
        self.output = output
    }
    
    func fetchParticipantSpectators() {
        output?.didReceiveParticipantSpectators(spectatorDate.participants)
    }
    
    func fetchDataForTitle() {
        output?.didReceiveGameQueueConfigId(spectatorDate.gameQueueConfigId)
    }
    
    func fetchBans() {
        output?.didReceiveBans(spectatorDate.bannedChampions)
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
