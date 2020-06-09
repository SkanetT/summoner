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

class LeagueRequest: BaseRequest<LeagueData> {
    
    private let summonerId: String
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/league/v4/entries/by-summoner/\(summonerId)"
    }
    init(summonerId: String, server: String) {
        self.summonerId = summonerId
        self.region = server
    }
    
    
}
