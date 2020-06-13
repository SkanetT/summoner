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
    case logOff
    
    var description: String {
        switch self {
        case .champions: return "Champions & Skins"
   //     case .items: return "Items"
        case .spells: return "Summoner spells"
        case .serversStatus: return "Servers status"
        case .logOff: return "Log Off"
        }
    }
    
    var image: UIImage {
        switch self {
        case .champions: return UIImage(systemName: "person") ?? UIImage()
  //      case .items: return UIImage(systemName: "text.bubble") ?? UIImage()
        case .spells: return UIImage(systemName: "circle.grid.3x3") ?? UIImage()
        case .serversStatus: return UIImage(systemName: "info") ?? UIImage()
        case .logOff: return UIImage(systemName: "arrowshape.turn.up.left") ?? UIImage()
        }
    }
    
}

