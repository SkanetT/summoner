//
//  SummonerData.swift
//  LoLProject
//
//  Created by Антон on 04.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct SummonerData: Codable {
    let id, accountID, puuid, name: String
    let profileIconID, revisionDate, summonerLevel: Int

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "accountId"
        case puuid, name
        case profileIconID = "profileIconId"
        case revisionDate, summonerLevel
    }
}
