//
//  ImageDownlow.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

extension UIImageView {
    func download(urlString: String) {
        var imageURL: URL?

        imageURL = URL(string: urlString)
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return (self.image = nil) }
        let downloadImage = UIImage(data: imageData)
        
        return self.image = downloadImage
    }
    
    
    
    func downloadSD(type: ImageType)
        {
            self.sd_setImage(with: type.url)
        }
    
}

enum ImageType {
    case itemIcon(id: String)
    case championIcon(id: String)
    case spellIcon(id: String)
    case profileIcon(id: String)
    case championWallpaper(id: String)
    case passiveSkillImage(name: String)
    case skillImage(name: String)
    
    
    
    var url: URL? {
        
        var version = ""
        
        let versions = try! Realm().objects(Version.self)
        
        if let lastVerion = versions.first?.lastVesion {
            version = lastVerion
        }
        
        switch self {
        case .itemIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/item/\(id).png")
        case.championIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/champion/\(id).png")
        case .spellIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/spell/\(id).png")
        case .profileIcon(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/profileicon/\(id).png")
        case .championWallpaper(let id):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(id)_0.jpg")
        case .passiveSkillImage(let name):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/passive/\(name)")
        case .skillImage(let name):
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/spell/\(name)")
        }
    }
    
}





