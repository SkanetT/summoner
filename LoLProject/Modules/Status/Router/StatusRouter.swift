//
//  StatusRouter.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class StatusRouter: StatusRouting {
    
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
        
    }
    
}
