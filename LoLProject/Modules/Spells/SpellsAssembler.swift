//
//  SpellsViewAssembler.swift
//  LoLProject
//
//  Created by Антон on 26.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellsAssembler {
    static func createModule() -> UIViewController {
        let viewController = SpellsController()
        let router = SpellsRouter(viewController)
        let interactor = SpellsInteractor()
        let tableHandler = SpellTableHandler()
        let presenter = SpellsPresenter(router, interactor)
        viewController.presenter = presenter
        viewController.tableViewHandler = tableHandler
        return viewController
    }
}
