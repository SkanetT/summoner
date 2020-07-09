//
//  SummonerTableHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol SummonerTableHandlerProtocol {
    func attach(_ tableView: UITableView)
    func setStartData(matchsArray: [ExpandableMathHistory], matchModel: [MatchModel])
    func updateData(_ matchModel: [MatchModel])
    func setUpgrade(_ reload: (() -> ())?)
    func hideTop(_ hide: ((Int) -> ())?)
    func updateIndex(_ index: Int)
    func setDataForHeader(_ data: LeagueData)
    func setLeague(_ league: ((String) -> ())?)
}
