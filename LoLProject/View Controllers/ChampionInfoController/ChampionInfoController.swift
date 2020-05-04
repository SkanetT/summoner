//
//  ViewController.swift
//  LoLProject
//
//  Created by Антон on 29.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ChampionInfoController: UIViewController {

    @IBOutlet var spellsTable: UITableView!
    var id = "Jinx"
    
    var champion = try! Realm().objects(Champion.self)

    @IBOutlet var championImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spellsTable.delegate = self
        spellsTable.dataSource = self
        spellsTable.register(UINib(nibName: "SpellsCell", bundle: nil), forCellReuseIdentifier: "spells")
//        spellsTable.estimatedRowHeight = 250
//        spellsTable.rowHeight = UITableView.automaticDimension
        
        
        getInfo(id: id) {[weak self] result in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    self?.title = champion.name + " " + champion.title
                }
            case .failure:
                print("Errort")
            }
        }

        let image = fetchImage(id: id)

        if image != nil {
            championImage.image = image
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissViewController))
    }

    @objc
    private func dismissViewController() {
        navigationController?.dismiss(animated: true)
    }
    
    private func fetchImage(id: String) -> UIImage? {
        var imageURL: URL?
        var image: UIImage?

        imageURL = URL(string:"https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(id)_0.jpg")
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return nil }
               
            image = UIImage(data: imageData)
               
        return(image)
    }
}

extension ChampionInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spells", for: indexPath) as! SpellsCell
        
        if indexPath.row == 0 {
            getInfo(id: id) {[weak cell] result in
                switch result {
                case .success(let champion):
                    DispatchQueue.main.async {
                        cell?.spellImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/passive/\(champion.passiveImage)")
                        cell?.spellName.text = champion.passiveName
                        cell?.spellDescription.attributedText = champion.passiveDescription.gettingAttributedText()
                    }
                case .failure:
                    print("error")
                }
            }
        }
        
        if indexPath.row == 1 {
            getInfo(id: id) {[weak cell] result in
                switch result {
                    case .success(let champion):
                        DispatchQueue.main.async {
                            cell?.spellImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(champion.qImage)")
                               cell?.spellName.text = "[Q] " + champion.qName
                               cell?.spellDescription.attributedText = champion.qDescription.gettingAttributedText()
                           }
                       case .failure:
                           print("error")
                       }
                   }
               }
        if indexPath.row == 2 {
                    getInfo(id: id) {[weak cell] result in
                        switch result {
                        case .success(let champion):
                            DispatchQueue.main.async {
                            cell?.spellImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(champion.wImage)")
                                      cell?.spellName.text = "[W] " + champion.wName
                                      cell?.spellDescription.attributedText = champion.wDescription.gettingAttributedText()
                                  }
                        case .failure:
                                  print("error")
                        }
                    }
                }
        if indexPath.row == 3 {
                   getInfo(id: id) {[weak cell] result in
                       switch result {
                       case .success(let champion):
                           DispatchQueue.main.async {
                            cell?.spellImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(champion.eImage)")
                               cell?.spellName.text = "[E] " + champion.eName
                               cell?.spellDescription.attributedText = champion.eDescription.gettingAttributedText()
                           }
                       case .failure:
                           print("error")
                       }
                   }
               }
        if indexPath.row == 4 {
                   getInfo(id: id) {[weak cell] result in
                       switch result {
                       case .success(let champion):
                           DispatchQueue.main.async {
                            cell?.spellImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/\(champion.rImage)")
                               cell?.spellName.text = "[R] " + champion.rName
                               cell?.spellDescription.attributedText = champion.rDescription.gettingAttributedText()
                           }
                       case .failure:
                           print("error")
                       }
                   }
               }
        return cell
    }
}



