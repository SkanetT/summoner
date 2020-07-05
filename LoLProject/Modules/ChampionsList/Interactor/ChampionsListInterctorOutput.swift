//
//  ChampionsListInterctorOutput.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionsListInteractorOutput: class {
    func didReceiveData(_ data:[ChampionListItem])
    func championInfoSuccess(_ champion: DataForFullInfo)
    func championInfoFailure(_ error: APIErrors)
}
