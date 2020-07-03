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
        viewController.spectatorDate = spectatorData
        return viewController
    }
    
    
}
