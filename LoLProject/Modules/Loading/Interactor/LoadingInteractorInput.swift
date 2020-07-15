//
//  LoadingInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoadingInteractorInput: class {
    func attach(_ output: LoadingInteractorOutput)
    func checkLastVersion()
}
