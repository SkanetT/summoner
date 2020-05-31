//
//  ViewController.swift
//  LoLProject
//
//  Created by Антон on 29.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ChampionInfoController: UIViewController {
    
    @IBOutlet var skillsTable: UITableView!
    
    
    var id = "Jinx"
    
    @IBOutlet var championImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillsTable.delegate = self
        skillsTable.dataSource = self
        
        skillsTable.allowsSelection = false
        
        skillsTable.register(UINib(nibName: "SkillCell", bundle: nil), forCellReuseIdentifier: "skill")
        
        NetworkAPI.shared.fetchFullInfoChampion(id: id) {[weak self] result in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    self?.title = champion.name + " " + champion.title
                }
            case .failure:
                print("Errort")
            }
        }
        
        championImage.downloadSD(type: .championWallpaper(id: id))
    }
    
    @objc
    private func dismissViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension ChampionInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skill", for: indexPath) as! SpellsCell
        
        
        
        NetworkAPI.shared.fetchFullInfoChampion(id: id){ result in
            switch result {
            case .success(let champion):
                switch indexPath.row {
                case 0:
                    cell.setData(isPassive: true, image: champion.passiveImage, name: champion.passiveName, description: champion.passiveDescription)
                case 1:
                    cell.setData(isPassive: false, image: champion.qImage, name: champion.qName, description: champion.qDescription)
                case 2:
                    cell.setData(isPassive: false, image: champion.wImage, name: champion.wName, description: champion.wDescription)
                case 3:
                    cell.setData(isPassive: false, image: champion.eImage, name: champion.eName, description: champion.eDescription)
                case 4:
                    cell.setData(isPassive: false, image: champion.rImage, name: champion.rName, description: champion.rDescription)                    
                default:
                    
                    break
                }
            case .failure:
                print("?")
            }
        }
        
        return cell
    }
}



