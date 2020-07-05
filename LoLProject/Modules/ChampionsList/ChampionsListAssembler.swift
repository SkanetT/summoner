//
//  ChampionsListAssembler.swift
//  LoLProject
//
//  Created by Антон on 03.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionsListAssembler {
    static func createModule() -> UIViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sb.instantiateViewController(identifier: "championList2")
        
        
        return viewController
    }
}
