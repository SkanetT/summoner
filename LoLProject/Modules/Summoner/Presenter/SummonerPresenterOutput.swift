//
//  SummonerPresenterOutput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerPresenterOutput: class {
    func didReceiveMostPlayedView(_ data: MostPlayedChampionsData)
    func didReceiveNoMostPlayedView()

}
