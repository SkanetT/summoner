//
//  SpellsRouter.swift
//  LoLProject
//
//  Created by Антон on 26.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellsRouter: SpellsRouting {
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
    
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
