//
//  StringGettingAttributedText.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

extension String {
    func gettingAttributedText() -> NSAttributedString? {
        
        
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
        
        let result = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                    options: options,
                                                    documentAttributes: nil)
        
        result?.addAttributes([NSAttributedString.Key.font:UIFont(name: "Avenir", size: 16.0)!], range:   NSRange(location:0 , length: result!.length))
        
        
        return result
    }
    
    func serverNameToRegion() -> String {
        var region = ""
        switch self {
        case "Europe West":
            region = "euw1"
        case "Europe Nordic & East":
            region = "eun1"
        case "Brazil":
            region = "br1"
        case "Latin America North":
            region = "la1"
        case "Latin America South":
            region = "la2"
        case "North America":
            region = "na1"
        case "Oceania":
            region = "oc1"
        case "Russia":
            region = "ru"
        case "Turkey":
            region = "tr1"
        case "Japan":
            region = "jp1"
        case "Republic of Korea":
            region = "kr"
        default:
            break
        }
        
        return region
    }
    
    func typeIdtoGameType() -> String {
        var result = ""
        switch  self {
        case "400":
            result = "Normal (Draft Pick)"
        case "420":
            result = "Ranked Solo/Duo"
        case "430":
            result = "Normal (Blind Pick)"
        case "440":
            result = "Ranked Flex"
        case "450":
            result = "ARAM"
        case "900":
            result = "Ultra Rapid Fire"
        case "700":
            result = "Clash"
        case "830":
            result = "Co-op vs. Intro Bots"
        case "840":
            result = "Co-op vs. Beginner Bots"
        case "850":
            result = "Co-op vs. Intermediate Bots"
        case "1020":
            result = "One for All"
        default:
            result = "Error type \(self)"
            
        }
        return result
    }
}


