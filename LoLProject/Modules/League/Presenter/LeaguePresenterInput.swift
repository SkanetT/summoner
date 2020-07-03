//
//  LeaguePresenterInput.swift
//  LoLProject
//
//  Created by Антон on 29.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LeaguePresenterInput: class {
    func attach(_ viewController: LeaguePresenterOutput)
    func viewDidLoad()
    func didSegmentChange(_ segmentIndex : Int)

}
