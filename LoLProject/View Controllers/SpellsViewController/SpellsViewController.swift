//
//  SpellsViewController.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class SpellsViewController: SpinnerController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allSpells = try! Realm().objects(SummonerSpell.self)
    var spellList: [String] = []
    
    private func allSpellsList() {
        for item in allSpells {
            spellList.append(item.name)
        }
        spellList = spellList.sorted()
    }
    
    
    @objc func exitSpells() {
           dismiss(animated: true, completion: nil)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        customiseNavigatorBar()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "SummonerSpellCell", bundle: nil), forCellReuseIdentifier: "summonerSpell")
        allSpellsList()
        
    }


    func customiseNavigatorBar() {
        title = "Spells"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitSpells))
        
    }
    
}


extension SpellsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summonerSpell", for: indexPath) as! SummonerSpellCell
        cell.nameLabel.text = spellList[indexPath.row]
        if let spell = allSpells.first(where: {$0.name == spellList[indexPath.row]}) {
            cell.descriptionLabel.text = spell.spellDescription
            
            cell.spellImage.downloadSD(type: .spellIcon(id: spell.id))
          
        }
        return cell
    }
    
    
}
