//
//  SpellsRouter.swift
//  LoLProject
//
//  Created by Антон on 26.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellsRouter: SpellsRouting {
    
    private weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
