//
//  ChampionsListAssembler.swift
//  LoLProject
//
//  Created by Антон on 03.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionsListAssembler {
    static func createModule() -> UIViewController {
        let viewController = ChampionsListController()
        let collectionHandler = ChampionsListCollectionHandler()
        let interactor = ChampionsListInteractor()
        let router = ChampionsListRouter(viewController)
        let presenter = ChampionsListPresenter(interactor, router)
        viewController.presenter = presenter
        viewController.collectionHandler = collectionHandler
        
        
        return viewController
    }
}
