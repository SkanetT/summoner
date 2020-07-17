//
//  AppRouter.swift
//  LoLProject
//
//  Created by Антон on 26.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class AppRouter {
    static func initViewController() -> UIViewController {

        let nvc = LoadingAssembler.createModule()
        
        return nvc
    }
}
