//
//  SummonerInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerInteractorInput: class {
    func attach(_ output: SummonerInteractorOutput)
    func fetchMostPlayedChampions()
}
