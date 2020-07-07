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
    func successSpectatorData(_ data: SpectatorData)
    func failureSpectatorData(_ error: APIErrors)

    func didReceiveSaveAndFoundSummoner(_ saveSummoner: SaveSummoner, _ foundSummoner: FoundSummoner)
}
