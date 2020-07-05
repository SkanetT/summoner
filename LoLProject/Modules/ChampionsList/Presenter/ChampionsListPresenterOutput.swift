//
//  ChampionsListPresenterOutput.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol ChampionsListPresenterOutput: class {
    func didReceiveChampionList(_ data:[ChampionListItem])
    func setActionForCell(_ userSelect: ((String) -> ())?)
    func championInfoLoadStart()

    func championInfoLoadComlete()

}
