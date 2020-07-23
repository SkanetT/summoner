//
//  ChampionsListInterctorInput.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionsListInteractorInput: class {
    func attach(_ output: ChampionsListInteractorOutput)
    func fecthData()
    func fetchChampionInfo(_ id: String)
}
