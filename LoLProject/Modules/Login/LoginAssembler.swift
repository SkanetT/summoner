//
//  LoginAssembler.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoginAssembler {
    static func createModule(delegate: LoginControllerDelegate) -> UIViewController {
        let viewController = LoginController()
        let interactor = LoginInteractor()
        let router = LoginRouter(viewController)
        router.delegate = delegate
        let presenter = LoginPresenter(interactor, router)
        viewController.presenter = presenter
        
        return viewController
    }
}
