//
//  MatchHistory.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation


struct MatchHistory: Codable {
    let matches: [Match]
}

struct Match: Codable {
    let gameId, champion, queue, season: Int
    let timestamp: Int
}
