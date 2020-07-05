//
//  ChampionsListPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionsListPresenterInput: class {
    func attach(_ viewController: ChampionsListPresenterOutput)
    func viewDidLoad()
    func didTapClose()

}
