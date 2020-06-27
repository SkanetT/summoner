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
    
    var presenter: SpellsPresenterInput?
    var tableViewHandler: SpellTableViewHandlerProtocol?

    @objc func exitSpells() {
        presenter?.didTapClose()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach(self)
        tableViewHandler?.attach(tableView)
        presenter?.viewDidLoad()
        
        #warning("TODO")
        customiseNavigatorBar()
        tableView.register(UINib(nibName: "SummonerSpellCell", bundle: nil), forCellReuseIdentifier: "summonerSpell")
        
    }


    func customiseNavigatorBar() {
        title = "Spells"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitSpells))
        
    }
    
}

extension SpellsViewController: SpellsPresenterOutput {
    func didReciveSpellList(_ spells: [SpellModel]) {
        tableViewHandler?.updateData(spells)
    }
    
}
