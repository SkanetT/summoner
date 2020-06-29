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
    
    static func fetchSpellIdfromKey(_ key: String) -> String? {
        let spells = try! Realm().objects(SummonerSpell.self)
        if let spell = spells.first(where: {$0.key == key}) {
            return spell.id
        } else {
            return nil
        }
    }
    
    
    static func fetchSpellList() -> Results<SummonerSpell> {
         return try! Realm().objects(SummonerSpell.self)
    }
}
