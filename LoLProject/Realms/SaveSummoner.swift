//
//  SaveSummoner.swift
//  LoLProject
//
//  Created by Антон on 23.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class SaveSummoner: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var region = ""
    @objc dynamic var profileIconId = 0
}
