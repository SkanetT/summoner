//
//  LeagueRouter.swift
//  LoLProject
//
//  Created by Антон on 01.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueRouter: LeagueRouting {
    
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ error: APIErrors) {
        viewController?.showErrorMessage(error)
    }
}
