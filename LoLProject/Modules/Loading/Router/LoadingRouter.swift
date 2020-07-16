//
//  LoadingRouter.swift
//  LoLProject
//
//  Created by Антон on 16.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoadingRouter: LoadingRouting {
    
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func windowContainer() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = ContainerController()
        }
    }
    func showError(_ error: APIErrors) {
        viewController?.showErrorMessage(error)
    }
}
