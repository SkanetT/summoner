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
        let tableHandler = SummonerTableHandler()
        let router = SummonerRouter(viewController)
        router.delegate = delegate
        let interactor = SummonerInteractor()
        let presenter = SummonerPresenter(interactor, router)
        viewController.presenter = presenter
        viewController.tableHandler = tableHandler
        
        return viewController
    }
}
