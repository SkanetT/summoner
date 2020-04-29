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
      //  getChampionsListRealm()
      

    }
    
    private func updateCurrentVersion() {
        // [weak self] слабый захват маст хев всегда с сетью, без него будет держатся ссылка на контроллер, пока запрос не завершит выполнение, утечка по памяти будет кароче
        verifyService.fetchCurrentVersion {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let version):
                
                DispatchQueue.main.async {
                    self.verLabel.text = version
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getChampionsListRealm(){
        
        networkChampionsManager.fetchCurrentChampions { result in
            switch result {
            case .success(let championData):
                let realm = try! Realm()
                for item in championData.data {
                    let champion = Champion()
                    champion.id = item.key
                    champion.name = item.value.name
                    champion.title = item.value.title
                    try! realm.write {
                        realm.add(champion)
                    }
                }
               
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
  
    
    
    
    
    
    ///////////////////////////
    
    @IBAction func didTapNext(_ sender: Any) {
        let viewController = TestViewController()
        viewController.someString = "1231"
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    
    
    
    
@IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}

