//
//  ChampionInfoInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionInfoInteractorInput: class {
    func attach(_ output: ChampionInfoInteractorOutput)
    func fecthData()

}
