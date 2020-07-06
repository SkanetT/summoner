//
//  ChampionInfoTableHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol ChampionInfoTableHandlerProtocol {
    func attach(_ tableView: UITableView)
    func setData(_ data: SelectedChampion, _ id: String)
    
}
