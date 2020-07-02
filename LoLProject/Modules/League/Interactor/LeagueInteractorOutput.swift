//
//  LeagueInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 01.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LeagueInteractorOutput: class {
    func didReciveTier(tier: [Entry], rank: String)
}
