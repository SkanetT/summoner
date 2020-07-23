//
//  ItemsData.swift
//  LoLProject
//
//  Created by Антон on 09.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct ItemsData: Codable {
    let data: [String: ItemDatum]
}

struct ItemDatum: Codable {
    let name, description, colloq, plaintext: String
    let gold: Gold
    let inStore: Bool?
    let into: [String]?
    let maps: [String: Bool]
    let from: [String]?
}

struct Gold: Codable {
    let base, total, sell: Int
}
