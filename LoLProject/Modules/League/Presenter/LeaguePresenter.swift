//
//  LeaguePresenter.swift
//  LoLProject
//
//  Created by Антон on 29.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LeaguePresenter: LeaguePresenterInput {
    
    private weak var viewController: LeaguePresenterOutput?
    private let interactor: LeagueInteractorInput
    private let router: LeagueRouting
    
    init(_ interactor:LeagueInteractorInput, _ router: LeagueRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func attach(_ viewController: LeaguePresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
       }
    
    func viewDidLoad() {
        interactor.fetchFoundSummonerInLeague()
        interactor.fetchDataForView()
        viewController?.setAction(userSelect: {[weak self] entry in
            self?.interactor.attemptToReconnect(summonerName: entry.summonerName)
        })
       }
    
    func didSegmentChange(_ segmentIndex: Int) {
        interactor.fetchNewTier(UserRank.init(rawValue: segmentIndex)?.title ?? "I")
    }
    
}

extension LeaguePresenter: LeagueInteractorOutput {
    func receiveData(_ data: RankData) {
        viewController?.fetchTitileAndImage(name: data.name, image: data.tier)
    }
    
    func reconnectSuccess() {
        router.dismiss()
    }
    
    func reconnectFailure(_ error: APIErrors) {
        router.showError(error)
    }
    
    func didReciveNewTier(_ tier: [Entry]) {
        viewController?.newTierHasCome(tier: tier)
    }
    
    func didReciveTier(tier: [Entry], rank: String) {
        viewController?.didReciveTier(tier: tier)
        viewController?.didReciveUserRank(.init(rank: rank))
    }
    
}

