//
//  Champion.swift
//  LoLProject
//
//  Created by Антон on 04.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class Champion: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var key = ""
}
