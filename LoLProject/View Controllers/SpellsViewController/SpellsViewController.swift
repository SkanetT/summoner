//
//  SpellsViewController.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class SpellsViewController: UIViewController {
    
    @IBOutlet weak var spellsTableView: UITableView!
    
    var allSpells = try! Realm().objects(SummonerSpell.self)
    var spellList: [String] = []
    
    private func allSpellsList() {
        for item in allSpells {
            spellList.append(item.name)
        }
        spellList = spellList.sorted()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spells"
        spellsTableView.delegate = self
        spellsTableView.register(UINib(nibName: "SummonerSpellCell", bundle: nil), forCellReuseIdentifier: "summonerSpell")
        allSpellsList()
        
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
            DispatchQueue.main.async {
                cell.spellImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(spell.id).png")
            }
          
        }
        return cell
    }
    
    
}
