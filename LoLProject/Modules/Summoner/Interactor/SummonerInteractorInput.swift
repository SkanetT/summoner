//
//  SummonerInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerInteractorInput: class {
    func attach(_ output: SummonerInteractorOutput)
    func fetchSaveAndFoundSummoners()
    func fetchSaveAndFoundSummonerNames()
    func rewriteSave()
    func fetchMostPlayedChampions()
    func fetchLeagueData()
    func fetchSpectatorData()
    func fetchMatchHistory()
    func fetchMatchs()
    func reloadMatch(disGroup: DispatchGroup, matchId: Int,region: String, reply: Int, summonerName: String, summonerId: String)
    func giveSpectatorData()
    func relogin(name: String)
    func fetchRankData(_ leagueId: String)
}
