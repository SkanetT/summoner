//
//  StatusPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol StatusPresenterInput: class {
    func attach(_ viewController: StatusPresenterOutput)
    func didTapClose()
    
}
