//
//  LoginAssembler.swift
//  LoLProject
//
//  Created by Антон on 30.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoginAssembler {
    static func createModuler(complition: @escaping (InititalControllerList) -> ()) -> UIViewController {
        let vc = UIViewController()
        return vc
    }
    
    enum InititalControllerList {
        case login
        case summoner
    }
}
