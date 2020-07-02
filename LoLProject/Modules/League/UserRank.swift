//
//  UserRank.swift
//  LoLProject
//
//  Created by Антон on 02.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

enum UserRank:Int, CaseIterable {
    
    case one
    case two
    case three
    case four
    
    var title: String {
        switch self {
        case .one:
            return "I"
        case .two:
            return "II"
        case .three:
            return "III"
        case .four:
            return "IV"
        }
    }
    
    init(rank: String) {
        self = UserRank.allCases.first(where: {$0.title == rank}) ?? .one
    }
}
