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
    
    func setAction(userSelect: ((String) -> ())?) {
        self.userSelectCell = userSelect
    }
}

extension ChampionsListCollectionHandler: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return championsListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newListCell", for: indexPath) as! ChampionsListCell
        cell.nameLabel.text = championsListArray[indexPath.row].name
        
        cell.championImage.downloadSD(type: .championIcon(id: championsListArray[indexPath.row].id))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSelectCell?(championsListArray[indexPath.row].id)
    }
}
