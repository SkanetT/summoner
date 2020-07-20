//
//  LeagueTableHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 28.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol LeagueTableHandlerProtocol {
    func attach(_ tableView: UITableView)
    func updateData(tier: [Entry])
    func setAction(userSelect: ((Entry) -> ())?)
    func setScroll(scroll:( () -> ())? )
}
