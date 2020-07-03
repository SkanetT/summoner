//
//  LeagueInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 01.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LeagueInteractorOutput: class {
    func receiveData(_ data: RankData)
    func didReciveTier(tier: [Entry], rank: String)
    func didReciveNewTier(_ tier: [Entry])
    func reconnectSuccess()
    func reconnectFailure(_ error: APIErrors)
}
