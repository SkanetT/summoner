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
    
    
    func championsItems() {
        for item in allChampion {
            champList.append(ChampionItem(name: item.name, id: item.id))
        }
        champList = champList.sorted(by: {$0.name < $1.name})
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        championsItems()
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return champList.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champions", for: indexPath) as! CollectionViewControllerCellCollectionViewCell
        cell.nameLabel.text = champList[indexPath.row].name
        
        let image = imageForCell(index: indexPath.row)
        
        if image != nil {
            cell.championImage.image = image
        }
        

        
        return cell
    }
    
    
    private func imageForCell(index: Int) -> UIImage? {
        var imageURL: URL?
        var image: UIImage?

        imageURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.8.1/img/champion/\(champList[index].id).png")
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return nil }
        
        image = UIImage(data: imageData)
        
        return(image)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(champList[indexPath.row].name)
        
        let champController = ChampionInfoController()
        champController.name = champList[indexPath.row].name
        champController.id = champList[indexPath.row].id
        let navController = UINavigationController(rootViewController: champController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
}


