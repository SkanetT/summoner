//
//  Errors.swift
//  LoLProject
//
//  Created by Антон on 26.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

enum APIErrors: Error {
    case statusCode(_ id: Int)
    case noData
    case network
    case parsing
    case unknown
    case noInternet
    
    var desc: String {
        switch self {
        case .noInternet:
            return "No Internet connection"
        case .unknown:
            return "Unknown error (2)"
        case .noData:
            return "No data"
        default:
            return "Unknown error, try refresh"
        }
    }
}

