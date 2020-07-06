//
//  ChampionsListRouter.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionsListRouter: ChampionsListRouting {
    
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
    
    func goToChampionInfo(_ champion: DataForFullInfo) {
        DispatchQueue.main.async {
            
            let vc = ChampionInfoAssembler.createModule(data: champion.data, id: champion.id)
            
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
}
