//
//  SummonerAssembler.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerAssembler {
    static func createModule(delegate: LoginControllerDelegate) -> UIViewController {
        let viewController = SummonerController()
        let interactor = SummonerInteractor()
        viewController.delegate = delegate
        let presenter = SummonerPresenter(interactor)
        viewController.presenter = presenter

        return viewController
    }
}
