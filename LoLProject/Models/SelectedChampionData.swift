//
//  SelectedChampionData.swift
//  LoLProject
//
//  Created by Антон on 01.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct SelectedChampionsData: Codable {
    let type, format, version: String
    let data: [String: Info]
}

struct Info: Codable {
    let id, key, name, title: String
    let lore: String
    let skins: [Skin]
    let spells: [Spell]
    let passive: Passive
}

struct Spell: Codable {
    let id, name, description, tooltip: String
    let image: Image
}

struct Passive: Codable {
    let name, description: String
    let image: Image
}
struct Image: Codable {
    let full, sprite, group: String
}




struct Skin: Codable {
let name: String
let num: Int
}
