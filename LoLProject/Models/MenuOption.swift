//
//  MenuOption.swift
//  LoLProject
//
//  Created by Антон on 06.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

enum MenuOption: Int {
    
    case champions
//    case items
    case spells
    case serversStatus
    case news
    case logOff
    
    var description: String {
        switch self {
        case .champions: return "Champions & Skins"
        case .spells: return "Summoner spells"
        case .serversStatus: return "Servers status"
        case .news: return "News"
        case .logOff: return "Log Off"
        }
    }
    
    var image: UIImage {
        switch self {
        case .champions: return UIImage(systemName: "person") ?? UIImage()
        case .spells: return UIImage(systemName: "circle.grid.3x3") ?? UIImage()
        case .serversStatus: return UIImage(systemName: "info") ?? UIImage()
        case .news: return UIImage(systemName: "book") ?? UIImage()
        case .logOff: return UIImage(systemName: "arrowshape.turn.up.left") ?? UIImage()
        }
    }
    
}

