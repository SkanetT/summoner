//
//  MatchHistory.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation


struct MatchHistory: Codable {
    var matches: [Match]
}

struct Match: Codable {
    let gameId, champion, queue, season: Int
    let timestamp: Int
}


class MatchHistoryRequest: BaseRequest<MatchHistory> {
    
    private let accountId: String
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/match/v4/matchlists/by-account/\(accountId)"
    }
    init(accountId: String, server: String) {
        self.accountId = accountId
        self.region = server
    }
}
