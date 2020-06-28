//
//  LeagueAssembler.swift
//  LoLProject
//
//  Created by Антон on 28.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueAssembler {
    static func createModule(_ rankData: RankData) -> UIViewController {
        let viewController = LeagueController ()
        viewController.rankData = rankData
        
        return viewController
    }
    
}
