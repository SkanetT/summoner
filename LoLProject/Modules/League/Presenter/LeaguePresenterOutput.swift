//
//  LeaguePresenterOutput.swift
//  LoLProject
//
//  Created by Антон on 29.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LeaguePresenterOutput: class {
    func didReciveTier(tier: [Entry])
    func didReciveUserRank(_ rank: UserRank)
    func setAction(userSelect: ((Entry) -> ())?)
    func newTierHasCome(tier: [Entry])
    func fetchTitileAndImage(name: String, image: String)
}
