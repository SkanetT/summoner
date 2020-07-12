//
//  SpellsViewController.swift
//  LoLProject
//
//  Created by Антон on 10.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpellsController: SpinnerController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SpellsPresenterInput?
    var tableViewHandler: SpellTableHandlerProtocol?

    @objc func exitSpells() {
        presenter?.didTapClose()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach(self)
        tableViewHandler?.attach(tableView)
        presenter?.viewDidLoad()
                
        title = "Spells"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitSpells))
        tableView.register(UINib(nibName: "SummonerSpellCell", bundle: nil), forCellReuseIdentifier: "summonerSpell")
        
    }

    
}

extension SpellsController: SpellsPresenterOutput {
    func didReciveSpellList(_ spells: [SpellModel]) {
        tableViewHandler?.updateData(spells)
    }
    
}
