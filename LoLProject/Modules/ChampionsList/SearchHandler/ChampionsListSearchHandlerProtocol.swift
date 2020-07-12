//
//  ChampionsListSearchHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 12.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol ChampionsListSearchHandlerProtocol {
    func attach(_ searchController: UISearchController)
    func setSearch(search: ((String) -> ())?)

}
