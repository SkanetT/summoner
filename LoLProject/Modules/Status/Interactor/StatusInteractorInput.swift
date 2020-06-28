//
//  StatusInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol StatusInteractorInput: class {
    func attach(_ output: StatusInteractorOutput)
    func fetchServerList()
}
