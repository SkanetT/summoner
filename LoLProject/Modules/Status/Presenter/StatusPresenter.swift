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
    
    
    func attach(_ viewController: StatusPresenterOutput) {
        self.viewController = viewController
    }
    
    func didTapClose() {
        router.dismiss()
       }
    
    init (_ router: StatusRouting) {
        self.router = router
    }
}
