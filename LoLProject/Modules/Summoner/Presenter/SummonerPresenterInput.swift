//
//  SummonerPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SummonerPresenterInput: class {
    func attach(_ viewController: SummonerPresenterOutput)
    func viewDidLoad()
}
