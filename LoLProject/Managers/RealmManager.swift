//
//  RealmManager.swift
//  LoLProject
//
//  Created by Антон on 26.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static func fetchFoundSummoner() -> FoundSummoner? {
        let summoner = try! Realm().objects(FoundSummoner.self)
        if let foundSummoner = summoner.first {
            return foundSummoner
        } else {
            return nil
        }
    }
    
    static func fetchSaveSummoner() -> SaveSummoner? {
        let summoner = try! Realm().objects(SaveSummoner.self)
        if let saveSummoner = summoner.first {
            return saveSummoner
        } else {
            return nil
        }
    }
    
    static func loginSummoner(summonerData: SummonerData, region: String) {
        
        let realm = try! Realm()
        let foundSummoner = FoundSummoner()
        foundSummoner.name = summonerData.name
        foundSummoner.id = summonerData.id
        foundSummoner.accountId = summonerData.accountId
        foundSummoner.puuid = summonerData.puuid
        foundSummoner.profileIconId = summonerData.profileIconId
        foundSummoner.summonerLevel = summonerData.summonerLevel
        foundSummoner.region = region
        
        let saveSummoner = SaveSummoner()
        saveSummoner.name = summonerData.name
        saveSummoner.id = summonerData.id
        saveSummoner.profileIconId = summonerData.profileIconId
        saveSummoner.region = region
        
        try! realm.write {
            realm.add(foundSummoner)
            realm.add(saveSummoner)
        }
    }
    
    static func deleteSummoner() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner(), let saveSummoner = RealmManager.fetchSaveSummoner() else { return }
        let realm = try! Realm()
        try! realm.write {
            realm.delete(foundSummoner)
            realm.delete(saveSummoner)
        }
    }
    
    static func swapSummoners(_ summonerData: SummonerData) {
        guard let foundSummoner = RealmManager.fetchFoundSummoner(), let saveSummoner = RealmManager.fetchSaveSummoner() else { return }
        let realm = try! Realm()
        let newFoundSummoner = FoundSummoner()
        newFoundSummoner.name = summonerData.name
        newFoundSummoner.id = summonerData.id
        newFoundSummoner.accountId = summonerData.accountId
        newFoundSummoner.puuid = summonerData.puuid
        newFoundSummoner.profileIconId = summonerData.profileIconId
        newFoundSummoner.summonerLevel = summonerData.summonerLevel
        newFoundSummoner.region = saveSummoner.region
        
        let newSaveSummoner = SaveSummoner()
        newSaveSummoner.name = summonerData.name
        newSaveSummoner.id = summonerData.id
        newSaveSummoner.profileIconId = summonerData.profileIconId
        newSaveSummoner.region = saveSummoner.region
        
        try! realm.write {
            realm.delete(foundSummoner)
            realm.delete(saveSummoner)
            
            realm.add(newFoundSummoner)
            realm.add(newSaveSummoner)
        }
        
    }
    
    static func reWriteFoundSummoner(_ summonerData: SummonerData) {
        guard let foundSummoner = RealmManager.fetchFoundSummoner() else { return }
        
        let realm = try! Realm()
        
        let newSummoner = FoundSummoner()
        newSummoner.name = summonerData.name
        newSummoner.id = summonerData.id
        newSummoner.accountId = summonerData.accountId
        newSummoner.puuid = summonerData.puuid
        newSummoner.profileIconId = summonerData.profileIconId
        newSummoner.summonerLevel = summonerData.summonerLevel
        newSummoner.region = foundSummoner.region
        
        try! realm.write {
            realm.delete(foundSummoner)
            realm.add(newSummoner)
            
        }
    }
    
    static func reWriteSaveSummoner() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner(), let saveSummoner = RealmManager.fetchSaveSummoner() else { return }
        
        let realm = try! Realm()
        let newSaveSummoner = SaveSummoner()
        newSaveSummoner.id = foundSummoner.id
        newSaveSummoner.name = foundSummoner.name
        newSaveSummoner.profileIconId = foundSummoner.profileIconId
        newSaveSummoner.region = foundSummoner.region
        
        try! realm.write {
            realm.delete(saveSummoner)
            realm.add(newSaveSummoner)
        }
    }
    
    static func fetchChampionIdfromKey(_ key: String) -> String? {
        let champions = try! Realm().objects(Champion.self)
        if let champion = champions.first(where: {$0.key == key}) {
            return champion.id
        } else {
            return nil
        }
    }
    
    static func fetchChampionfromKey(_ key: String) -> Champion? {
        let champions = try! Realm().objects(Champion.self)
        if let champion = champions.first(where: {$0.key == key}) {
            return champion
        } else {
            return nil
        }
    }
    
    static func fetchSpellIdfromKey(_ key: String) -> String? {
        let spells = try! Realm().objects(SummonerSpell.self)
        if let spell = spells.first(where: {$0.key == key}) {
            return spell.id
        } else {
            return nil
        }
    }
    
    static func fetchLastVersion() -> String? {
        let version = try! Realm().objects(Version.self)
        if let lastVersion = version.first {
            return lastVersion.lastVesion
        } else {
            return nil
        }
    }
    
    static func fetchSpellList() -> Results<SummonerSpell> {
        return try! Realm().objects(SummonerSpell.self)
    }
}
