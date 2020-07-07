//
//  SummonerRouter.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerRouter: SummonerRouting {
    
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
    
    func spectatorPresent(_ data: SpectatorData) {
        DispatchQueue.main.async {
            let vc = SpectatorAssembler.createModule(data)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
