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
        interactor.fetchMatchHistory()
        interactor.fetchLeagueData()
        viewController?.scrollingDown({[weak self] () in
            self?.interactor.fetchMatchs()
            
        })
        viewController?.leagueTaped() {[weak self] leagueId in
            self?.interactor.fetchRankData(leagueId)
        }
        
    }
    
    func spectatorDidTap() {
        interactor.giveSpectatorData()
    }
}

extension SummonerPresenter: SummonerInteractorOutput {
    func successRank(_ data: RankData) {
        router.rankPresent(data)
    }
    
    func failureRank(_ error: APIErrors) {
        router.showError(error)
    }
    
    func successLeague(_ data: LeagueData) {
        viewController?.didReceiveLeague(data)
    }
    
    func failureLeague(_ error: APIErrors) {
        router.showError(error)
    }
    
    func successRelogin() {
        router.dismiss()
    }
    
    func failureRelogin(_ error: APIErrors) {
        router.showError(error)
    }
    
    func didReceiveUpdateForTable(_ matchModel: [MatchModel]) {
        viewController?.dataForTable(matchModel)
    }
    
    func didReceiveDataForTable(matchsArray: [ExpandableMathHistory], matchModel: [MatchModel]) {
        viewController?.firstDataForTable(matchsArray: matchsArray, matchModel: matchModel)
    }
    
    func successMatchHistory() {
        interactor.fetchMatchs()
    }
    
    func failureMatchHistory(_ error: APIErrors) {
        router.showError(error)
    }
    
    func didReceiveDataForSpectator(_ data: SpectatorData) {
        router.spectatorPresent(data)
    }
    
    func successSpectatorData() {
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
