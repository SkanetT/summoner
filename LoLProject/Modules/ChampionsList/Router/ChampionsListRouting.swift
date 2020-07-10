//
//  ChampionsListRouting.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionsListRouting {
    func dismiss()
    func goToChampionInfo(_ champion: DataForFullInfo)
    func showError(_ error: APIErrors )

}
