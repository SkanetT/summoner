//
//  SummonerPresenterOutput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerPresenterOutput: class {
    func didReceiveMostPlayedView(_ data: MostPlayedChampionsData)
    func didReceiveNoMostPlayedView()
    func didReceiveLeague(_ data: LeagueData)
    func didReceiveDataForSummoner(_ name: String, _ region: String, _ level: String, _ profileId: String)
    func summonerOnline()
    func summomerOffline()
    func isSaveSummoner(_ isSaveSummoner: Bool)
    func firstDataForTable(matchsArray: [ExpandableMathHistory], matchModel: [MatchModel])
    func dataForTable(_ matchModel: [MatchModel])
    func scrollingDown(_ reload: (() -> ())?)
    func leagueTaped(_ league: ((String) -> ())?)
}
