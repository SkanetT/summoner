//
//  ChampionsData.swift
//  LoLProject
//
//  Created by Антон on 26.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct ChampionsData: Codable {
    let data: [String: Datum]
    let version: String

}

struct Datum: Codable {
    let name, title: String
}

