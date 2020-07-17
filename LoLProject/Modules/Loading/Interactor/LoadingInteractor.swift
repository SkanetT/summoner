//
//  LoadingInteractor.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class LoadingInteractor: LoadingInteractorInput {
    
    private weak var output: LoadingInteractorOutput?
    
    var loadingIsSuccess = true
    
    
    func attach(_ output: LoadingInteractorOutput) {
        self.output = output
    }
    
    let group = DispatchGroup()
    
    func checkLastVersion() {
        let version = RealmManager.fetchLastVersion()
        
        let realm = try! Realm()
        if version != nil {
            NetworkAPI.shared.fetchCurrentVersion() {[weak self] result in
                
                guard let self = self else { return }
                switch result {
                case .success(let lastVersion):
                    if version == lastVersion {
                        self.output?.loadingDone()
                    } else {
                        DispatchQueue.main.async {
                            try! realm.write {
                                realm.deleteAll()
                            }
                            self.getVersionRealm(lastVersion)
                            self.getChampionsListRealm(version: lastVersion, group: self.group)
                            self.getSpellsListRealm(version: lastVersion    , group: self.group)
                        }
                    }
                case.failure(let error):
                    self.output?.loadingNotDone(error)
                }
            }
        } else {
            NetworkAPI.shared.fetchCurrentVersion() {[weak self] result in
                
                guard let self = self else { return }
                switch result {
                case .success(let lastVersion):
                    if version == lastVersion {
                        self.output?.loadingDone()
                    } else {
                        DispatchQueue.main.async {
                            try! realm.write {
                                realm.deleteAll()
                            }
                            self.getVersionRealm(lastVersion)
                            self.getChampionsListRealm(version: lastVersion, group: self.group)
                            self.getSpellsListRealm(version: lastVersion, group: self.group)
                        }
                    }
                case.failure(let error):
                    self.output?.loadingNotDone(error)
                }
                
            }
        }
        
        group.notify(queue: .main) {[weak self] in
            guard let self = self else { return }
            if self.loadingIsSuccess {
                self.output?.loadingDone()
            } else {
                let error = APIErrors.unknown
                self.output?.loadingNotDone(error)
            }
        }
        
    }
    
    func getVersionRealm(_ lastVersion: String) {
        let realm = try! Realm()
        let version = Version()
        version.lastVesion = lastVersion
        try! realm.write {
            realm.add(version)
        }
    }
    
    func getChampionsListRealm(version: String, group: DispatchGroup) {
        group.enter()
        NetworkAPI.shared.fetchCurrentChampionsList(version: version) {[weak self] result in
            switch result {
            case .success(let championData):
                let realm = try! Realm()
                for item in championData.data {
                    let champion = Champion()
                    champion.id = item.key
                    champion.name = item.value.name
                    champion.key = item.value.key
                    try! realm.write {
                        realm.add(champion)
                    }
                }
                group.leave()
            case.failure:
                self?.loadingIsSuccess = false
                group.leave()
            }
        }
    }
    
    func getSpellsListRealm(version: String, group: DispatchGroup) {
        group.enter()
        NetworkAPI.shared.fetchCurrentSpellsList() {[weak self] result in
            switch result {
            case.success(let spellsData):
                let realm = try! Realm()
                let items = spellsData.data.filter{$0.key != "SummonerSnowURFSnowball_Mark"}
                items.forEach { item in
                    let spell = SummonerSpell()
                    spell.id = item.key
                    spell.name = item.value.name
                    spell.key = item.value.key
                    spell.spellDescription = item.value.description
                    spell.tooltip = item.value.tooltip
                    try! realm.write {
                        realm.add(spell)
                    }
                }
                group.leave()
            case .failure:
                self?.loadingIsSuccess = false
                group.leave()
            }
        }
    }
}


