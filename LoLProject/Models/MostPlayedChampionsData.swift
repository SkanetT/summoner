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
