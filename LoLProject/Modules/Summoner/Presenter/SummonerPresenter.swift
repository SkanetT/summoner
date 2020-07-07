//
//  SummonerPresenter.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class SummonerPresenter: SummonerPresenterInput {
    
    private weak var viewController: SummonerPresenterOutput?
    let interactor: SummonerInteractorInput
    let router: SummonerRouting


    init (_ interactor: SummonerInteractorInput, _ router: SummonerRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func attach(_ viewController: SummonerPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    
    func viewDidLoad() {
        interactor.fetchSaveAndFoundSummoners()
        interactor.fetchMostPlayedChampions()
        interactor.fetchSpectatorData()
        
    }
    
    func spectatorDidTap() {
        
    }
}

extension SummonerPresenter: SummonerInteractorOutput {
    func successSpectatorData(_ data: SpectatorData) {
        viewController?.summonerOnline()

    }
    
    func didReceiveSaveAndFoundSummoner(_ saveSummoner: SaveSummoner, _ foundSummoner: FoundSummoner) {
        viewController?.didReceiveDataForSummoner(foundSummoner.name, foundSummoner.region, foundSummoner.summonerLevel.description, foundSummoner.profileIconId.description)
        if saveSummoner.id == foundSummoner.id {
            viewController?.isSaveSummoner(true)
        } else {
            viewController?.isSaveSummoner(false)
        }
        
    }
    
    
    func failureSpectatorData(_ error: APIErrors) {
        switch error {
        case.noData:
            viewController?.summomerOffline()
        case .network, .noInternet, .parsing, .unknown, .statusCode(_):
            router.showError(error)
        }
    }

    
    func successMostPlayedChampions(_ data: MostPlayedChampionsData) {
        if data.count >= 3 {
            viewController?.didReceiveMostPlayedView(data)
        } else {
            viewController?.didReceiveNoMostPlayedView()
        }
    }
    
    func failureMostPlayedChampions(_ error: APIErrors) {
        router.showError(error)
    }
    
    
}
