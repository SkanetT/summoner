//
//  StatusPresenter.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class StatusPresenter: StatusPresenterInput {
  
    
   
    private weak var viewController: StatusPresenterOutput?
    private let router: StatusRouting
    private let interactor: StatusInteractorInput
    
    
    func attach(_ viewController: StatusPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    
    func didTapClose() {
        router.dismiss()
       }
    
    func viewDidLoad() {
        interactor.fetchServerList()
    }
    
    init (_ router: StatusRouting,_ interactor: StatusInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension StatusPresenter: StatusInteractorOutput {
    func didReciveServerList(servers: [String]) {
        viewController?.didReciveServerList(servers: servers)
    }
    
    
}
