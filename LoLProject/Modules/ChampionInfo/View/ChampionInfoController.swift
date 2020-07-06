//
//  ViewController.swift
//  LoLProject
//
//  Created by Антон on 29.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class ChampionInfoController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tableHandler: ChampionInfoTableHandlerProtocol?
    var presenter: ChampionInfoPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableHandler?.attach(tableView)
        presenter?.attach(self)
        presenter?.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false        
        tableView.allowsSelection = false
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitChampions))
    }
    
    @objc func exitChampions() {
        presenter?.didTapClose()
    }
}

extension ChampionInfoController: ChampionInfoPresenterOutput {
    func didReceiveTitle(_ title: String) {
        self.title = title
    }
    
    func dataHasCome(data: SelectedChampion, id: String) {
        tableHandler?.setData(data, id)
    }
}
