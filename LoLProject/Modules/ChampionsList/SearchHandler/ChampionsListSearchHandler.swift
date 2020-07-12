//
//  ChampionsListSearchHandler.swift
//  LoLProject
//
//  Created by Антон on 12.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionsListSearchHandler: NSObject, ChampionsListSearchHandlerProtocol {
    
    private weak var searchController: UISearchController?
    var search: ((String) -> ())?

    func attach(_ searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search champion"
        searchController.searchBar.tintColor = .white
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white            
        }
        self.searchController = searchController
    }
    
    func setSearch(search: ((String) -> ())?) {
        self.search = search
    }
}

extension ChampionsListSearchHandler: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        search?(text)
    }
}
