//
//  ChampionInfoAssembler.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionInfoAssembler {
    static func createModule(data: SelectedChampion, id: String) -> UIViewController {
        let viewController = ChampionInfoController()
        let tableHandler = ChampionInfoTableHandler()
        let interactor = ChampionInfoInteractor()
        let router = ChampionInfoRouter(viewController)
        interactor.championData = data
        interactor.id = id
        let presenter = ChampionInfoPresenter(interactor, router)
        viewController.tableHandler = tableHandler
        viewController.presenter = presenter
        
        return viewController
    }
}
