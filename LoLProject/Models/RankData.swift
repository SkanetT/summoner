//
//  RankData.swift
//  LoLProject
//
//  Created by Антон on 03.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct RankData: Codable {
    let tier, leagueId, queue, name: String
    let entries: [Entry]

  
}

struct Entry: Codable {
    let summonerId, summonerName: String
    let leaguePoints: Int
    let rank: String
    let wins, losses: Int
    let veteran, inactive, freshBlood, hotStreak: Bool
    let miniSeries: MiniSeries?
}

struct MiniSeries: Codable {
    let target, wins, losses: Int
    let progress: String
}


class RankRequest: BaseRequest<RankData> {
    
    private let leagueId: String
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/league/v4/leagues/\(leagueId)"
    }
    init(leagueId: String, server: String) {
        self.leagueId = leagueId
        self.region = server
    }
    
    
}
