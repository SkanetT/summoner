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
    
    @objc
    private func dismissViewController() {
        navigationController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        championsItems()
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return champList.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champions", for: indexPath) as! CollectionViewControllerCellCollectionViewCell
        cell.nameLabel.text = champList[indexPath.row].name
        cell.championImage.image = nil
       imageForCell(index: indexPath.row, completion: { image in
            cell.championImage.image = image
        })
        
        return cell
    }
    
    
    private func imageForCell(index: Int, completion: @escaping (UIImage?) -> ()) {
        var imageURL: URL?
        
       DispatchQueue(label: "com.lolproject", qos: .background).async {
            imageURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.8.1/img/champion/\(self.champList[index].id).png")
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(champList[indexPath.row].name)
        
        let champController = ChampionInfoController()
        champController.id = champList[indexPath.row].id
        let navController = UINavigationController(rootViewController: champController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
}


