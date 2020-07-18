//
//  ImageDownlow.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func leagueImage(league: String) {
        switch league {
        case "IRON":
            self.image = #imageLiteral(resourceName: "Iron")
        case "BRONZE":
            self.image = #imageLiteral(resourceName: "Bronze")
        case "SILVER":
            self.image = #imageLiteral(resourceName: "Silver")
        case "GOLD":
            self.image = #imageLiteral(resourceName: "Gold")
        case "PLATINUM":
            self.image = #imageLiteral(resourceName: "Platinum")
        case "DIAMOND":
            self.image = #imageLiteral(resourceName: "Diamond")
        case "CHALLENGER":
            self.image = #imageLiteral(resourceName: "Challenger")
        case "MASTER":
            self.image = #imageLiteral(resourceName: "Master")
        case "GRANDMASTER":
            self.image = #imageLiteral(resourceName: "Grandmaster")
        default:
            self.image = #imageLiteral(resourceName: "Unranked")
        }
    }
    
    
    func downloadSD(type: ImageType)
    {
        
        self.sd_imageIndicator = SDWebImageActivityIndicator.white
        
        self.sd_setImage(with: type.url)
    }
    
    func downloadSDPlaceHolder(type: ImageType)
    {
        
        self.sd_setImage(with: type.url, placeholderImage: #imageLiteral(resourceName: "Bronze"))
        
    }
}

enum ImageType {
    case itemIcon(id: String)
    case championIcon(id: String)
    case spellIcon(id: String)
    case profileIcon(id: String)
    case championWallpaper(id: String, index: String)
    case passiveSkillImage(name: String)
    case skillImage(name: String)
    
    
    
    var url: URL? {
        
        var version = ""
                
        if let lastVerion = RealmManager.fetchLastVersion() {
            version = lastVerion
        }
        
        switch self {
        case .itemIcon(let id):
            if id == "0" {
                return URL(string: "https://vignette.wikia.nocookie.net/leagueoflegends/images/d/d5/Item.png/revision/latest?cb=20171221062712")
            } else {
                return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/item/\(id).png")
            }
        case.championIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/champion/\(id).png")
        case .spellIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/spell/\(id).png")
        case .profileIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/profileicon/\(id).png")
        case .championWallpaper(let id, let index):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(id)_\(index).jpg")
        case .passiveSkillImage(let name):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/passive/\(name)")
        case .skillImage(let name):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/spell/\(name)")
        }
    }
    
}





