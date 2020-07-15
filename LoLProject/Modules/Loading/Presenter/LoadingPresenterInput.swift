//
//  LoadingPresenterInput.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoadingPresenterInput: class {
    func attach(_ viewController: LoadingPresenterOutput)
    func viewDidLoad()

}
