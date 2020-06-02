//
//  InfoViewController.swift
//  LoLProject
//
//  Created by Антон on 04.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import SDWebImage

class InfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.register(UINib(nibName: "CellForInfoView", bundle: nil), forCellReuseIdentifier: "cellForInfoView")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cellForInfoView", for: indexPath) as! CellForInfoView
        switch indexPath.row {
        case 0:
            cell.imageCell.downloadSD(type: .championIcon(id: "Jinx"))
            cell.textCell.numberOfLines = 2
            cell.textCell.text = "Champions & Skins"
        case 1:
            cell.imageCell.downloadSD(type: .itemIcon(id: "3026"))
            cell.textCell.text = "Items"
        case 2:
            cell.imageCell.downloadSD(type: .spellIcon(id: "SummonerFlash"))
            cell.textCell.text = "Spells"
            
        default:
            break
        }
           cell.layer.borderWidth = 3
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "championList")
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("Not yet")
        case 2:
            let vc = SpellsViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
