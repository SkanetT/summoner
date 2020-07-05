//
//  SpectatorPresenter.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class SpectatorPresenter: SpectatorPresenterInput {
    
    private weak var viewController: SpectatorPresenterOutput?
    let interactor: SpectatorInteractorInput
    let router: SpectatorRouting
    
    init (_ interactor: SpectatorInteractorInput, _ router: SpectatorRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    
    func attach(_ viewController: SpectatorPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    func viewDidLoad() {
        interactor.fetchParticipantSpectators()
        interactor.fetchDataForTitle()
        interactor.fetchBans()
        viewController?.setActionForCell(){[weak self] summonerName in
            self?.interactor.attemptToReconnect(summonerName: summonerName)
        }
    }
    
}

extension SpectatorPresenter: SpectatorInteractorOutput {
    func didReceiveBans(_ bans: [BannedChampion]) {
        if bans.isEmpty {
            viewController?.noBansInMatch()
        } else {
            viewController?.matchHasBans(bans)
        }
        
    }
    
    func didReceiveGameQueueConfigId(_ gameQueueConfigId: Int?) {
        viewController?.didReciveTitle(gameQueueConfigId?.description.typeIdtoGameType())
    }
    
    func didReceiveParticipantSpectators(_ participantSpectators: [ParticipantSpectator]) {
        viewController?.didReceiveDataForFirstTeam(participantSpectators.filter{ $0.teamId == 100 })
        viewController?.didReceiveDataForSecondTeam(participantSpectators.filter{ $0.teamId == 200 })
    }
    
    func reconnectSuccess() {
        router.dismiss()
    }
    
    func reconnectFailure(_ error: APIErrors) {
        print(error)
    }
    
}
