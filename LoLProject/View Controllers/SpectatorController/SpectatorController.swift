//
//  SpectatorController.swift
//  LoLProject
//
//  Created by Антон on 14.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class SpectatorController: UIViewController {
    
    var spectatorDate: SpectatorDate?
    
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
    
    @IBOutlet weak var banStack1: UIStackView!
    @IBOutlet weak var banStack2: UIStackView!
    
    
    
    let champions = try! Realm().objects(Champion.self)
    
   
    
    lazy var coll1 : CollectionViewDelegate = {
        let data = spectatorDate?.participants.filter{ $0.teamId == 100 }
        return .init(data: data ?? [])
    }()
    
    lazy var coll2 : CollectionViewDelegate = {
        let data = spectatorDate?.participants.filter{ $0.teamId == 200 }
        return .init(data: data ?? [])
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
//        collection1.register(SpectatorCell.self, forCellWithReuseIdentifier: "spectatorCell")
        
        collection1.register(UINib(nibName: "SpectatorCell", bundle: nil), forCellWithReuseIdentifier: "spectatorCell")
        
        collection1.dataSource = coll1
        collection1.delegate = coll1

        
        collection1.reloadData()

       
        

        collection2.register(UINib(nibName: "SpectatorCell", bundle: nil), forCellWithReuseIdentifier: "spectatorCell")
        collection2.dataSource = coll2
            collection2.delegate = coll2
        collection2.reloadData()


        
        
        setupBanStackViews()
    }
    
    
    func setupBanStackViews() {
        
        guard let spectatorDate = spectatorDate else { return }
        banStack1.distribution = .fillEqually
        banStack1.alignment = .center
        banStack1.spacing = 2
        
        banStack2.distribution = .fillEqually
        banStack2.alignment = .center
        banStack2.spacing = 2
        
        for i in 0...4 {
            
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .lightGray
            image.clipsToBounds = true
            image.layer.cornerRadius = 5
            
            image.translatesAutoresizingMaskIntoConstraints = false
            image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
            
            if let champion = champions.first(where: { $0.key == spectatorDate.bannedChampions[i].championId.description}) {
                image.downloadSD(type: .championIcon(id: champion.id))
                
            } else {
                image.image = nil
            }
            banStack1.addArrangedSubview(image)
        }
        
        for i in 5...9 {
            
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .lightGray
            image.clipsToBounds = true
            image.layer.cornerRadius = 5
            
            if let champion = champions.first(where: { $0.key == spectatorDate.bannedChampions[i].championId.description}) {
                image.downloadSD(type: .championIcon(id: champion.id))
            } else {
                image.image = nil
            }
            banStack2.addArrangedSubview(image)
        }
        
        
        
    }
    
    // ARC
    
}

class CollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var participantSpectators = [ParticipantSpectator]()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participantSpectators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spectatorCell", for: indexPath) as? SpectatorCell {
            
            cell.summonerNameLabel.text = participantSpectators[indexPath.row].summonerName
            return cell
        } else {
            return .init()
        }
    }
    
    init(data: [ParticipantSpectator]) {
        self.participantSpectators = data
        
        
        
    }
    
    
}

// netfox
