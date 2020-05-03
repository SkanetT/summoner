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
    
    let networkChampionsManager = NetworkChampionsManager()
    let verifyService = VerifyVersion()
    
       // Вот это дичь, но без этого у нас не будет сильной ссылки на верверсион, и соотвеств
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet var verLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrentVersion()
        
    
        
        let realm = try! Realm()
        let version = try! Realm().objects(Version.self)
        if let lastVersion = version.first?.lastVesion {
            verifyService.fetchCurrentVersion {[weak self] result in
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
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        let viewController = TestViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
@IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}


