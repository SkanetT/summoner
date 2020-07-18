//
//  LoginRouter.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouting {
    
    private weak var viewController: UIViewController?
    weak var delegate: LoginControllerDelegate?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func sideMenu() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func showError(_ error: APIErrors) {
        viewController?.showErrorMessage(error)
    }
    
    func showWrongName() {
        let ac = UIAlertController(title: "Incorrect Summoner name", message: "Names must be at least 3 characters long and no more than 16 characters long.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(ok)
        
        viewController?.present(ac, animated: true)
    }
    
    func presentSummoner() {
        let container = ContainerController()
        container.isLogin = false
        
        container.modalPresentationStyle = .fullScreen
        viewController?.present(container, animated: true)
    }
    
    func showNoSummoner(_ name: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "\(name) not found", message: "Check summoner name and region", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            ac.addAction(ok)
            self.viewController?.present(ac, animated: true)
        }
    }
    
    func showPicker() {
        
    }
}
