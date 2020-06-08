//
//  BaseRequest.swift
//  LoLProject
//
//  Created by Антон on 08.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
class BaseRequest<T: Decodable>: BaseRequestProtocol {
    
    typealias response = T
    
    var path: String {
        return ""
    }
    
    var server: String  {
        return ""
    }
    
    
    var urlRequest: URLRequest? {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "\(server).api.riotgames.com"
        comp.path = self.path
        guard let url = comp.url else { return nil }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [ "X-Riot-Token": "\(GlobalConstants.shared.apiKey)"]
        return request
    }
    
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
