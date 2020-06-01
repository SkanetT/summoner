//
//  StringGettingAttributedText.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

extension String {
    func gettingAttributedText() -> NSAttributedString?{
    

    let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        
    let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
        NSAttributedString.DocumentType.html]
        
     let result = try? NSMutableAttributedString(data: htmlData ?? Data(),
     options: options,
     documentAttributes: nil)
        
    result?.addAttributes([NSAttributedString.Key.font:UIFont(name: "Avenir", size: 16.0)!], range:   NSRange(location:0 , length: result!.length))

    return result
    }
}


