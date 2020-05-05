//
//  FoundSummoner.swift
//  LoLProject
//
//  Created by Антон on 05.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class FoundSummoner: Object {
    @objc dynamic var id = ""
    @objc dynamic var accountId = ""
    @objc dynamic var puuid = ""
    @objc dynamic var name = ""
    @objc dynamic var profileIconId = 0
    @objc dynamic var revisionDate = 0
    @objc dynamic var summonerLevel = 0
}
