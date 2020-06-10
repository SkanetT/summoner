//
//  StatusData.swift
//  LoLProject
//
//  Created by Антон on 10.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct StatusData: Codable {
    let services: [Service]

    
}
struct Service: Codable {
    let status: String
}

class StatusRequest: BaseRequest<StatusData> {
    
    private let region: String
    
    override var server: String {
        return region
    }
    
    override var path: String{
        return "/lol/status/v3/shard-data"
    }
    init(server: String) {
        self.region = server
    }
}
