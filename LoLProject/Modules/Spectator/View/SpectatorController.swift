//
//  SpectatorController.swift
//  LoLProject
//
//  Created by Антон on 14.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpectatorController: UIViewController {
    
    var presenter: SpectatorPresenterInput?
    
    var collectionHandler1: SpectatorCollectionHandlerProtocol?
    var collectionHandler2: SpectatorCollectionHandlerProtocol?
    
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
    @IBOutlet weak var noBanesLabel: UILabel!
    
    @IBOutlet weak var banStack1: UIStackView!
    @IBOutlet weak var banStack2: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionHandler1?.attach(collection1)
        collectionHandler2?.attach(collection2)
        
        presenter?.attach(self)
        presenter?.viewDidLoad()
        
        collection1.clipsToBounds = true
        collection1.layer.cornerRadius = 10
        
        collection2.clipsToBounds = true
        collection2.layer.cornerRadius = 10
        
        noBanesLabel.clipsToBounds = true
        noBanesLabel.layer.cornerRadius = 10
        
        banStack1.distribution = .fillEqually
        banStack1.alignment = .center
        banStack1.spacing = 2
        
        banStack2.distribution = .fillEqually
        banStack2.alignment = .center
        banStack2.spacing = 2
    }
}

extension SpectatorController: SpectatorPresenterOutput {
    func matchHasBans(_ bans: [BannedChampion]) {
        guard bans.count == 10 else { return }
        noBanesLabel.isHidden = true
        
        for i in 0...4 {
            
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .lightGray
            image.clipsToBounds = true
            image.layer.cornerRadius = 5
            
            image.translatesAutoresizingMaskIntoConstraints = false
            image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
            
            if let championId = RealmManager.fetchChampionIdfromKey(bans[i].championId.description) {
                image.downloadSD(type: .championIcon(id: championId))
            }
            
            banStack1.addArrangedSubview(image)
        }
        
        for i in 5...9 {
            
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .lightGray
            image.clipsToBounds = true
            image.layer.cornerRadius = 5
            
            if let championId = RealmManager.fetchChampionIdfromKey(bans[i].championId.description) {
                image.downloadSD(type: .championIcon(id: championId))
            }
            
            banStack2.addArrangedSubview(image)
        }
    }
    
    func noBansInMatch() {
        noBanesLabel.isHidden = false
    }
    
    func setActionForCell(_ userSelect: ((String) -> ())?) {
        collectionHandler1?.setAction(userSelect: userSelect)
        collectionHandler2?.setAction(userSelect: userSelect)
        
    }
    
    func didReciveTitle(_ title: String?) {
        self.title = title
    }
    
    func didReceiveDataForFirstTeam(_ data: [ParticipantSpectator]) {
        collectionHandler1?.updateData(participantSpectator: data)
    }
    
    func didReceiveDataForSecondTeam(_ data: [ParticipantSpectator]) {
        collectionHandler2?.updateData(participantSpectator: data)
    }
    
}

