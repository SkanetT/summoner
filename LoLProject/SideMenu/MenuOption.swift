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
    case spells
    case serversStatus
    case news
    
    var description: String {
        switch self {
        case .champions: return "Champions & Skins"
        case .spells: return "Summoner spells"
        case .serversStatus: return "Servers status"
        case .news: return "News"
        }
    }
    
    var image: UIImage {
        switch self {
        case .champions: return UIImage(systemName: "person") ?? UIImage()
        case .spells: return UIImage(systemName: "rectangle.grid.1x2") ?? UIImage()
        case .serversStatus: return UIImage(systemName: "antenna.radiowaves.left.and.right") ?? UIImage()
        case .news: return UIImage(systemName: "doc.richtext") ?? UIImage()
        }
    }
    
}

