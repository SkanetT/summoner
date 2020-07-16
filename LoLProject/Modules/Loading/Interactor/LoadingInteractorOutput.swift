//
//  LoadingInteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoadingInteractorOutput: class {
    func loadingDone()
    func loadingNotDone(_ error: APIErrors)
}
