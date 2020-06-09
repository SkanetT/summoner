//
//  MostPlayedShampionsData.swift
//  LoLProject
//
//  Created by Антон on 05.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct MostPlayedChampionsDatum: Codable {
    let championId, championLevel, championPoints: Int
    let championPointsSinceLastLevel, championPointsUntilNextLevel: Int
}


typealias MostPlayedChampionsData = [MostPlayedChampionsDatum]

class MostPlayedChampionsRequest: BaseRequest<MostPlayedChampionsData> {
    
    private let summonerId: String
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/champion-mastery/v4/champion-masteries/by-summoner/\(summonerId)"
    }
    init(summonerId: String, server: String) {
        self.summonerId = summonerId
        self.region = server
    }
    
    
}
