//
//  SummonerData.swift
//  LoLProject
//
//  Created by Антон on 04.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct SummonerData: Codable {
    let id, accountId, puuid, name: String
    let profileIconId, revisionDate, summonerLevel: Int

}
