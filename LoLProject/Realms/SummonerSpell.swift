//
//  Spell.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class SummonerSpell: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var key: String = ""
    @objc dynamic var spellDescription: String = ""
    @objc dynamic var tooltip: String = ""
}
