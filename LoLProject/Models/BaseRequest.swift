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


