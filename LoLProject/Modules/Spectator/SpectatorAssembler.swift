//
//  SpectatorAssembler.swift
//  LoLProject
//
//  Created by Антон on 03.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpectatorAssembler {
    static func createModule(_ spectatorData: SpectatorDate) -> UIViewController {
        let viewController = SpectatorController()
        let collectionHandler1 = SpectatorCollectionHandler()
        let collectionHandler2 = SpectatorCollectionHandler()
        let router = SpectatorRouter(viewController)
        let interactor = SpectatorInteractor(spectatorData)
        let presenter = SpectatorPresenter(interactor, router)
        viewController.presenter = presenter

        viewController.collectionHandler1 = collectionHandler1
        viewController.collectionHandler2 = collectionHandler2
   //     viewController.spectatorDate = spectatorData
        return viewController
    }
    
    
}
