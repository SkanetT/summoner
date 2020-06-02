//
//  ChampionsViewController.swift
//  LoLProject
//
//  Created by Антон on 25.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ChampionsViewController: UICollectionViewController {
    
    var allChampion = try! Realm().objects(Champion.self)
    
    struct ChampionItem {
        let name: String
        let id: String
    }
    
    var champList: [ChampionItem] = []
    
    
    
   private func championsItems() {
        for item in allChampion {
            champList.append(ChampionItem(name: item.name, id: item.id))
        }
        champList = champList.sorted(by: {$0.name < $1.name})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Champions"
       
        championsItems()
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champions", for: indexPath) as! ChampionsViewControllerCell
        cell.nameLabel.text = champList[indexPath.row].name
        
        cell.championImage.downloadSD(type: .championIcon(id: champList[indexPath.row].id))
        
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NetworkAPI.shared.fetchFullInfoChampion(id: champList[indexPath.row].id) {[weak self] result in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    let champController = ChampionInfoController()
                    champController.championData = champion
                    champController.id = self!.champList[indexPath.row].id
                    self?.navigationController?.pushViewController(champController, animated: true)
                }
            case .failure:
                print("Errort")
            }
        }
        
        
    }
    
}


