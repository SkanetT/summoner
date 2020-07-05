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
            
            return cell
        } else {
            return .init()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.visibleSize
        
        
        return CGSize(width: size.width * 0.75, height: size.height - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        
     //   let server = foundSummoner.region
        
        if participantSpectators[indexPath.row].summonerId != foundSummoner.id {
            
            
            userSelectCell?(participantSpectators[indexPath.row].summonerName)
            
            
//            let request = SummonerRequest(summonerName: participantSpectators[indexPath.row].summonerName, server: server)
//            NetworkAPI.shared.dataTask(request: request) { result in
//            //    guard let self = self else { return }
//                switch result {
//                case.success(let summonerData):
//                    DispatchQueue.main.async {
//
//                        RealmManager.reWriteFoundSummoner(summonerData)
//                   //     self.delegate?.dissmissAll()
//                    }
//
//                case.failure(let error):
//                    print(error)
//                }
//            }
            
        }
        
    }
    
    
//    init(data: [ParticipantSpectator], delegate: SpectatorDelegate ) {
//        self.delegate = delegate
//        self.participantSpectators = data
//
//    }
    
}
