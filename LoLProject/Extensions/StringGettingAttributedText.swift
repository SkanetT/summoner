//
//  StringGettingAttributedText.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

extension String {
    func gettingAttributedText() -> NSAttributedString?{
    let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
    let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
        NSAttributedString.DocumentType.html]
    return try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                             options: options,
                                                             documentAttributes: nil)
    }
}

//    private func gettingAttributedText(label: UILabel, text: String) {
//        let htmlData = NSString(string: text).data(using: String.Encoding.unicode.rawValue)
//        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
//            NSAttributedString.DocumentType.html]
//        if let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
//                                                                 options: options,
//                                                                 documentAttributes: nil) {
//            label.attributedText = attributedString
//        } else {
//            label.text = text
//        }
//    }
