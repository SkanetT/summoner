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


class SummonerRequest: BaseRequest<SummonerData> {
    
    private let summonerName: String
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/summoner/v4/summoners/by-name/\(summonerName)"
    }
    init(summonerName: String, server: String) {
        self.summonerName = summonerName
        self.region = server
    }
}
