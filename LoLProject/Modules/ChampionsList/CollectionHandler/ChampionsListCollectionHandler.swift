//
//  ChampionsListCollectionHandler.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionsListCollectionHandler: NSObject, ChampionsListCollectionHandlerProtocol {
    
    private weak var collectionView: UICollectionView?
    
    var championsListArray: [ChampionListItem] = []
    var userSelectCell: ((String) -> ())?
    var filteredChampionsListArray: [ChampionListItem] = []
    var isFilter = false
    
    func attach(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.register(UINib(nibName: "ChampionsListCell", bundle: nil), forCellWithReuseIdentifier: "newListCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setData(_ data: [ChampionListItem]) {
        self.championsListArray = data
        collectionView?.reloadData()
    }
    
    func searchReload(_ search: String) {
        guard search != "" else {
            isFilter = false
            collectionView?.reloadData()
            return
        }
        filteredChampionsListArray = championsListArray.filter( {$0.name.lowercased().contains(search.lowercased())} )
        isFilter = true
        collectionView?.reloadData()
    }
    
    func setAction(userSelect: ((String) -> ())?) {
        self.userSelectCell = userSelect
    }
}

extension ChampionsListCollectionHandler: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFilter {
            return filteredChampionsListArray.count
        } else {
            return championsListArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newListCell", for: indexPath) as! ChampionsListCell
        
        if isFilter {
            cell.nameLabel.text = filteredChampionsListArray[indexPath.row].name
            cell.championImage.downloadSD(type: .championIcon(id: filteredChampionsListArray[indexPath.row].id))
            
        } else {
            cell.nameLabel.text = championsListArray[indexPath.row].name
            cell.championImage.downloadSD(type: .championIcon(id: championsListArray[indexPath.row].id))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFilter {
            userSelectCell?(filteredChampionsListArray[indexPath.row].id)
        } else {
            userSelectCell?(championsListArray[indexPath.row].id)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = (screenSize.width / 3) - 18
        return CGSize(width: screenWidth, height: screenWidth * 1.3)
    }
    
}
