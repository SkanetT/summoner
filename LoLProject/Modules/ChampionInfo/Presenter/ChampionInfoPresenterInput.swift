//
//  ChampionInfoPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionInfoPresenterInput: class {
    func attach(_ viewController: ChampionInfoPresenterOutput)
    func viewDidLoad()
    func didTapClose()

}
