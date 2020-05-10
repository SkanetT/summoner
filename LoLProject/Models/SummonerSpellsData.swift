//
//  SummonerSpellsData.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct SummonerSpellsData: Codable {
    let data: [String: SpellsData]
}

struct SpellsData: Codable {
    let id, name, description , tooltip: String
    let key: String
}
