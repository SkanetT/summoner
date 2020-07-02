//
//  LeagueAssembler.swift
//  LoLProject
//
//  Created by Антон on 28.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueAssembler {
    static func createModule(_ rankData: RankData) -> UIViewController {
        let viewController = LeagueController ()
        viewController.rankData = rankData
        let router = LeagueRouter(viewController)
        let tableHandler = LeagueTableHandler()
        let interactor = LeagueInteractor(data: rankData)
        let presenter = LeaguePresenter(interactor, router)
        viewController.presenter = presenter
        viewController.tableHandler = tableHandler
        return viewController
    }
    
}
