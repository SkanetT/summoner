//
//  ChampionsListController.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
//import RealmSwift

class ChampionsListController: SpinnerController {
    
    var presenter: ChampionsListPresenterInput?
    
    var collectionHandler: ChampionsListCollectionHandlerProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    @objc func exitChampions() {
        presenter?.didTapClose()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionHandler?.attach(collectionView)
        
        presenter?.attach(self)
        presenter?.viewDidLoad()
        title = "Champions"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitChampions))
 
    }
}

extension ChampionsListController: ChampionsListPresenterOutput {
    func championInfoLoadStart() {
        showSpinner()
    }
    
    func championInfoLoadComlete() {
       removeSpinner()
    }
    
    func setActionForCell(_ userSelect: ((String) -> ())?) {
        collectionHandler?.setAction(userSelect: userSelect)
    }
    
    func didReceiveChampionList(_ data: [ChampionListItem]) {
        collectionHandler?.setData(data)
    }
        
}
