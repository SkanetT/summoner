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
//        interactor.filterByTiers()
        interactor.fetchFoundSummonerInLeague()
        viewController?.setAction(userSelect: { entry in
            print(entry.summonerName)
        })
       }
}

extension LeaguePresenter: LeagueInteractorOutput {
    func didReciveTier(tier: [Entry], rank: String) {
//        viewController?.didReciveTier(tier: tier, rank: rank)
        viewController?.didReciveTier(tier: tier)
        viewController?.didReciveUserRank(.init(rank: rank))
    }
    
}

