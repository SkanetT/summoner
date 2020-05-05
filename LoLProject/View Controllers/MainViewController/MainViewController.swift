//
//  ViewController.swift
//  LoLProject
//
//  Created by Антон on 25.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    let networkAPI = NetworkAPI()
    
    let realm = try! Realm()
    let foundSummoner = try! Realm().objects(FoundSummoner.self)
    
    @IBOutlet var verLabel: UILabel!
    @IBOutlet var summonerNameTF: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        updateCurrentVersion()
        let realm = try! Realm()
        let version = try! Realm().objects(Version.self)
        if let lastVersion = version.first?.lastVesion {
            networkAPI.fetchCurrentVersion() {[weak self] result in
                switch result {
                case .success(let version):
                    if version != lastVersion {
                        DispatchQueue.main.async {
                            try! realm.write {
                                realm.deleteAll()
                            }
                            self?.getVersionRealm()
                            self?.getChampionsListRealm()
                        }
                    }
                case.failure:
                print("error")
                }
            }
        } else {
            DispatchQueue.main.async {
                self.getVersionRealm()
                self.getChampionsListRealm()
            }
        }
        
        if !foundSummoner.isEmpty {
            let summonerVC = SummonerViewController()
            navigationController?.pushViewController(summonerVC, animated:  true)
        }
    }
    
    
    @IBAction func searchDidTapped(_ sender: UIButton) {
        
        var summonerName = summonerNameTF.text
        summonerName = summonerName?.split(separator: " ").joined(separator: "%20")
        
        networkAPI.seachSummoner(name: summonerName!) { result in
            switch result {
            case .success(let summoner):
                

                let realm = try! Realm()
                let foundSummoner = FoundSummoner()
                
                foundSummoner.name = summoner.name
                foundSummoner.id = summoner.id
                foundSummoner.accountId = summoner.accountId
                foundSummoner.puuid = summoner.puuid
                foundSummoner.profileIconId = summoner.profileIconId
                foundSummoner.summonerLevel = summoner.summonerLevel
                
                try! realm.write {
                    realm.add(foundSummoner)
                }
                DispatchQueue.main.async {
                    let summonerVC = SummonerViewController()
                    self.navigationController?.pushViewController(summonerVC, animated: true)
                }
                
            case.failure(let error):
                if error == .summonerNotFound {
                    let ac = UIAlertController(title: "Summoner not found", message: nil, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    ac.addAction(ok)
                    DispatchQueue.main.async {
                        self.present(ac, animated: true)
                    }
                }
            }
        }
    }
    
}


