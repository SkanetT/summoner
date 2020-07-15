//
//  LoadingPresenter.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LoadingPresenter: LoadingPresenterInput {
    
    private weak var viewController: LoadingPresenterOutput?
    let interactor: LoadingInteractorInput

    
    init (_ interactor:LoadingInteractorInput) {
        self.interactor  = interactor
        
    }
    
    func attach(_ viewController: LoadingPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)

    }
    
    func viewDidLoad() {
        interactor.checkLastVersion()
        
    }
    
}

extension LoadingPresenter: LoadingInteractorOutput {
    func loadingDone() {
        print("ok")
    }
    
    
}
