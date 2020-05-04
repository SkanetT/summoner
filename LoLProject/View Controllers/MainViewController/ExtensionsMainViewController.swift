//
//  ExtensionsMainViewController.swift
//  LoLProject
//
//  Created by Антон on 01.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

extension MainViewController {
    
    func updateCurrentVersion() {
        networkAPI.fetchCurrentVersion() {[weak self] result in
               guard let self = self else { return }
               switch result {
               case .success(let version):
                   
                   DispatchQueue.main.async {
                       self.verLabel.text = version
                   }
               case .failure(let error):
                   print(error)
               }
           }
       }
    
    func getChampionsListRealm(){
        networkAPI.fetchCurrentChampionsList() { result in
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
                  
               case.failure(let error):
                   print(error)
               }
           }
       }
       
    func getVersionRealm() {
        networkAPI.fetchCurrentVersion() { result in
               switch result {
               case .success(let lastVersion):
                   let realm = try! Realm()
                   let version = Version()
                   version.lastVesion = lastVersion
                   try! realm.write {
                       realm.add(version)
                   }
               case .failure(let error):
                   print(error)
               }
           }
       }
}
