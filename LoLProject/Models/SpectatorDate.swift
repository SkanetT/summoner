//
//  SpectatorDate.swift
//  LoLProject
//
//  Created by Антон on 14.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct SpectatorDate: Codable {
    let gameId: Int
    let gameQueueConfigId: Int?
    let participants: [ParticipantSpectator]
    let bannedChampions: [BannedChampion]
}


struct ParticipantSpectator: Codable {
    let teamId, spell1Id, spell2Id, championId: Int
    let profileIconId: Int
    let summonerName: String
    let summonerId: String

}


struct BannedChampion: Codable {
    let championId, teamId, pickTurn: Int

}


class SpectatorRequest: BaseRequest<SpectatorDate> {
    
    private let summonerId: String
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/spectator/v4/active-games/by-summoner/\(summonerId)"
    }
    init(summonerId: String, server: String) {
        self.summonerId = summonerId
        self.region = server
    }
}
