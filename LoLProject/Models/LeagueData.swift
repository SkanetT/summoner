//
//  LeagueData.swift
//  LoLProject
//
//  Created by Антон on 07.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

typealias LeagueData = [LeagueDatum]

struct LeagueDatum: Codable {
    let leagueId, queueType, tier, rank: String
    let leaguePoints, wins, losses: Int
    let veteran, inactive, freshBlood, hotStreak: Bool
}


