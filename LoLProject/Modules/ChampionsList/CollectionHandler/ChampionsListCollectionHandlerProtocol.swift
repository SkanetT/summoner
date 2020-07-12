//
//  ChampionsListCollectionHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol ChampionsListCollectionHandlerProtocol {
    func attach(_ collectionView: UICollectionView)
    func setData(_ data: [ChampionListItem])
    func searchReload(_ search: String)

    func setAction(userSelect: ((String) -> ())?)

}
