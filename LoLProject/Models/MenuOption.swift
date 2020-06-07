//
//  MenuOption.swift
//  LoLProject
//
//  Created by Антон on 06.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case champions
    case items
    case spells
    
    var description: String {
        switch self {
        case .champions: return "Champions & Skins"
        case .items: return "Items"
        case .spells: return "Summoner spells"
        }
    }
    
    var image: UIImage {
        switch self {
        case .champions: return UIImage(systemName: "person") ?? UIImage()
        case .items: return UIImage(systemName: "text.bubble") ?? UIImage()
        case .spells: return UIImage(systemName: "circle.grid.3x3") ?? UIImage()
        }
    }
    
}

