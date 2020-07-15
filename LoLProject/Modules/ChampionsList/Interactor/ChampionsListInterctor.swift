//
//  ChampionsListInterctor.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class ChampionsListInteractor: ChampionsListInteractorInput {
    
    var champions = try! Realm().objects(Champion.self)
    
    private weak var output: ChampionsListInteractorOutput?
    
    func attach(_ output: ChampionsListInteractorOutput) {
        self.output = output
    }
    
    func fecthData() {
        var championsList: [ChampionListItem] = []
        for item in champions {
            championsList.append(ChampionListItem(name: item.name, id: item.id))
        }
        output?.didReceiveData(championsList)
    }
    
    func fetchChampionInfo(_ id: String) {
        guard let version = RealmManager.fetchLastVersion() else { return }
        NetworkAPI.shared.fetchFullInfoChampion(id: id, version: version) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let championData):
                let champion = DataForFullInfo(data: championData, id: id)
                self.output?.championInfoSuccess(champion)
            case .failure(let error):
                self.output?.championInfoFailure(error)
            }
        }
}
}
