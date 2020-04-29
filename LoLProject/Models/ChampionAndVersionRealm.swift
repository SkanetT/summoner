//
//  ChampionRealm.swift
//  LoLProject
//
//  Created by Антон on 27.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class Champion: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var title = ""
}


class Version: Object {
    @objc dynamic var lastVesion = "0.0"
}
