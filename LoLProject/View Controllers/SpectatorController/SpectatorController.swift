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
    @IBOutlet weak var noBanesLabel: UILabel!
    
    @IBOutlet weak var banStack1: UIStackView!
    @IBOutlet weak var banStack2: UIStackView!
    
    
    
    let champions = try! Realm().objects(Champion.self)
    
    
    
    
    lazy var coll1 : CollectionViewDelegate = {
        let data = spectatorDate?.participants.filter{ $0.teamId == 100 }
        return .init(data: data ?? [], delegate:  self)
    }()
    
    lazy var coll2 : CollectionViewDelegate = {
        let data = spectatorDate?.participants.filter{ $0.teamId == 200 }
        return .init(data: data ?? [], delegate: self)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = spectatorDate?.gameQueueConfigId?.description.typeIdtoGameType()
        
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
        
        noBanesLabel.isHidden = true
        noBanesLabel.clipsToBounds = true
        noBanesLabel.layer.cornerRadius = 10
        
        guard let spectatorDate = spectatorDate else {
            noBanesLabel.isHidden = false
            return
        }
        guard !spectatorDate.bannedChampions.isEmpty else { return }
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

extension SpectatorController: SpectatorDelegate {
    func dissmissAll() {        
        dismiss(animated: false, completion: nil)
    }
    
    
}

class CollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var participantSpectators = [ParticipantSpectator]()
    weak var delegate: SpectatorDelegate?
    
    
    
    let summoner = try! Realm().objects(FoundSummoner.self)
    
    
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
        guard let foundSummoner = summoner.first else { return }
        
        let server = foundSummoner.region
        
        
        
        if participantSpectators[indexPath.row].summonerId != foundSummoner.id {
            
            let request = SummonerRequest(summonerName: participantSpectators[indexPath.row].summonerName, server: server)
            NetworkAPI.shared.dataTask(request: request) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let summonerData):
                    print(summonerData.name)
                    DispatchQueue.main.async {

                        let realm = try! Realm()

                        
                        let foundSummoner = FoundSummoner()
                        foundSummoner.name = summonerData.name
                        foundSummoner.id = summonerData.id
                        foundSummoner.accountId = summonerData.accountId
                        foundSummoner.puuid = summonerData.puuid
                        foundSummoner.profileIconId = summonerData.profileIconId
                        foundSummoner.summonerLevel = summonerData.summonerLevel
                        foundSummoner.region = server
                        
                        
                        try! realm.write {
                            realm.delete(self.summoner)
                            realm.add(foundSummoner)
                            
                        }
                    
                        self.delegate?.dissmissAll()

                    }
                        
                    
                    
                case.failure(let error):
                    print(error)
                }
            }
            
        }
        
    }
    
    
    init(data: [ParticipantSpectator], delegate: SpectatorDelegate ) {
        
        self.delegate = delegate
        self.participantSpectators = data
        
    }
}



