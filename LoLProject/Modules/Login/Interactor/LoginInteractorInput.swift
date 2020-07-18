//
//  LoginInteractorInput.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoginInteractorInput: class {
    func attach(_ output: LoginInteractorOutput)
    func checkSummoner()
    func foundSummoner(_ name: String, _ region: String)
}
