//
//  StatusAssembler.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class StatusAssembler {
    
    static func createModule() -> UIViewController{
        let viewController = StatusController()
        let router = StatusRouter(viewController)
        let presenter = StatusPresenter(router)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
