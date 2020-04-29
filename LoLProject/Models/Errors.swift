//
//  Errors.swift
//  LoLProject
//
//  Created by Антон on 26.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

enum APIErrors: Error {
    case network
    case parsing
    case unknown
}
