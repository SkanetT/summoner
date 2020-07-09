//
//  SummonerInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerInteractorOutput: class {
    func successMostPlayedChampions(_ data: MostPlayedChampionsData)
    func failureMostPlayedChampions(_ error: APIErrors)
    func successLeague(_ data: LeagueData)
    func failureLeague(_ error: APIErrors)
    func successSpectatorData()
    func didReceiveDataForSpectator(_ data: SpectatorData)
    func failureSpectatorData(_ error: APIErrors)
    func didReceiveSaveAndFoundSummoner(_ saveSummoner: SaveSummoner, _ foundSummoner: FoundSummoner)
    func successMatchHistory()
    func failureMatchHistory(_ error: APIErrors)
    func didReceiveDataForTable(matchsArray: [ExpandableMathHistory], matchModel: [MatchModel])
    func didReceiveUpdateForTable(_ matchModel: [MatchModel])
    func successRelogin()
    func failureRelogin(_ error: APIErrors)
    func successRank(_ data: RankData)
    func failureRank(_ error: APIErrors)
}
