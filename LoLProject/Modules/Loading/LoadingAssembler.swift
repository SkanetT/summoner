//
//  LoadingAssembler.swift
//  LoLProject
//
//  Created by Антон on 30.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoadingAssembler {
    //    static func createModuler(complition: @escaping (InititalControllerList) -> ()) -> UIViewController {
    //        let vc = UIViewController()
    //        return vc
    
    static func createModule() -> UIViewController {
        let viewController = LoadingController()
        let router = LoadingRouter(viewController)
        let interactor = LoadingInteractor()
        let presenter = LoadingPresenter(interactor, router)
        viewController.presenter = presenter
        
        return viewController
    }
}

//    enum InititalControllerList {
//        case login
//        case summoner
//    }

