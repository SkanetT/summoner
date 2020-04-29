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
    
    var championsArray = [String]()
    
    
    private func arrayNames()  {
        for item in allChampion {
        championsArray.append(item.name)
        }
        championsArray = championsArray.sorted()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayNames()
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return championsArray.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champions", for: indexPath) as! CollectionViewControllerCellCollectionViewCell
        cell.nameLabel.text = championsArray[indexPath.row]
        
        let image = imageForCell(index: indexPath.row)
        
        if image != nil {
            cell.championImage.image = image
        }
        

        
        return cell
    }
    
    
    private func imageForCell(index: Int) -> UIImage? {
        var imageURL: URL?
        var image: UIImage?
        
        var soloName: String = ""
        
        for item in allChampion {
            if championsArray[index] == item.name {
                soloName = item.id
            }
        }

        imageURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.8.1/img/champion/\(soloName).png")
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return nil }
        
        image = UIImage(data: imageData)
        
        return(image)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(championsArray[indexPath.row])
    }
    
}

