//
//  SummonerInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerInteractorOutput: class {
    func successMostPlayedChampions(_ data: MostPlayedChampionsData)
    func failureMostPlayedChampions(_ error: APIErrors)
}
