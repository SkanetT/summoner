//
//  SpectatorPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol SpectatorPresenterInput: class {
    func attach(_ viewController: SpectatorPresenterOutput)
    func viewDidLoad()
}
