//
//  LeagueRouting.swift
//  LoLProject
//
//  Created by Антон on 01.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LeagueRouting {
    func dismiss()
    func showError(_ error: APIErrors )
}
