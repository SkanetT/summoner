//
//  SummonerRouting.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol SummonerRouting {
    func dismiss()
    func sideMenu()
    func showError(_ error: APIErrors )
    func spectatorPresent(_ data: SpectatorData)
    func rankPresent(_ data: RankData)
}
