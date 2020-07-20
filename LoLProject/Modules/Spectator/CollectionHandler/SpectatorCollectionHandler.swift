//
//  SpectatorCollectionHandler.swift
//  LoLProject
//
//  Created by Антон on 04.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpectatorCollectionHandler: NSObject, SpectatorCollectionHandlerProtocol {
    
    private weak var collectionView: UICollectionView?
    
    var userSelectCell: ((String) -> ())?
    
    func attach(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.register(UINib(nibName: "SpectatorCell", bundle: nil), forCellWithReuseIdentifier: "spectatorCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    var participantSpectators = [ParticipantSpectator]()
    
    
    func updateData(participantSpectator: [ParticipantSpectator]) {
        self.participantSpectators = participantSpectator
        collectionView?.reloadData()
    }
    
    func setAction(userSelect: ((String) -> ())?) {
        self.userSelectCell = userSelect
    }
    
}

extension SpectatorCollectionHandler: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participantSpectators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spectatorCell", for: indexPath) as? SpectatorCell {
            
            cell.setData(data: participantSpectators[indexPath.row])
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.black.cgColor
            
            
            return cell
        } else {
            return .init()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.visibleSize
        
        
        return CGSize(width: size.width * 0.8, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        if participantSpectators[indexPath.row].summonerId != foundSummoner.id {
            
            userSelectCell?(participantSpectators[indexPath.row].summonerName)
        }
        
    }
    
}
