//
//  ChampionInfoInteractor.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class ChampionInfoInteractor: ChampionInfoInteractorInput {
    
    
    
    var championData: SelectedChampion?
    var id: String?
    
    private weak var output: ChampionInfoInteractorOutput?

    func attach(_ output: ChampionInfoInteractorOutput) {
        self.output = output
    }
    
    func fecthData() {
        guard let championData = championData, let id = id else { return }
        output?.didReceiveDataAndId(data: championData, id: id)
    }
}
