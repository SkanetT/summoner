//
//  ChampionsViewController.swift
//  LoLProject
//
//  Created by Антон on 25.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ChampionsViewController: SpinnerController {
    
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
    
    @objc func exitChampions() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       customiseNavigatorBar()
        championsItems()
    }
    
    func customiseNavigatorBar() {
        title = "Champions"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitChampions))
        
    }
     
    
    
    
    
}

extension ChampionsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "champions", for: indexPath) as! ChampionsViewControllerCell
        cell.nameLabel.text = champList[indexPath.row].name
        
        cell.championImage.downloadSD(type: .championIcon(id: champList[indexPath.row].id))
        
        return cell
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.allowsSelection = false
        NetworkAPI.shared.fetchFullInfoChampion(id: champList[indexPath.row].id) {[weak self] result in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    collectionView.allowsSelection = true

                    let champController = ChampionInfoController()
                    champController.championData = champion
                    champController.id = self!.champList[indexPath.row].id
                    
                    self?.navigationController?.pushViewController(champController, animated: true)
                }
            case .failure(let error):
                print("\(error) for  champions")
            }
        }
        
        
    }
    
}


