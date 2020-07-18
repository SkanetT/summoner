//
//  LoginPresenter.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterInput {
    
    private weak var viewController: LoginPresenterOutput?
    let interactor: LoginInteractorInput

    let router: LoginRouting
    
    
    init(_ interactor: LoginInteractorInput, _ router: LoginRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func attach(_ viewController: LoginPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    func viewWillAppear() {
        interactor.checkSummoner()
    }
    
    func sideMenuTap() {
        router.sideMenu()
    }
    
    func serverChangeTap() {
        router.showPicker()
    }
    
    func didInputName(_ name: String, _ region: String) {
        if name.count < 3 || name.count > 16 {
            router.showWrongName()
        } else {
            interactor.foundSummoner(name, region.serverNameToRegion())
        }
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func isLogin() {
        router.presentSummoner()
    }
    
    func successFoundSummoner() {
        router.presentSummoner()
    }
    
    func successNoSummoner(_ name: String) {
        router.showNoSummoner(name)
    }
    
    func failureSummoner(_ error: APIErrors) {
        router.showError(error)
    }
}
