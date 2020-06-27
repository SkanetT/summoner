//
//  RealmManager.swift
//  LoLProject
//
//  Created by Антон on 26.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import RealmSwift
import Foundation

#warning("TO DO REALM ")

class RealmManager {
    
    static func fetchSpellList() -> Results<SummonerSpell> {
         return try! Realm().objects(SummonerSpell.self)
    }
}
