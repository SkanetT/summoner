//
//  LeagueInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 01.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LeagueInteractorInput: class {
    func attach(_ output: LeagueInteractorOutput)
    func fetchDataForView()
    func fetchFoundSummonerInLeague()
    func fetchNewTier(_ tier: String)
    func attemptToReconnect(summonerName: String)
}
