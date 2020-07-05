//
//  SpellTableHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol SpellTableHandlerProtocol {
    func attach(_ tableView: UITableView)
    func updateData(_ spellList: [SpellModel])
}
