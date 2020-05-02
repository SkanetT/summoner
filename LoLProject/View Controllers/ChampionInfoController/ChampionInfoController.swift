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

    var name = "None "
    var id = "Jinx"
    
    var champion = try! Realm().objects(Champion.self)
    
    @IBOutlet var championName: UILabel!
    @IBOutlet var championTitle: UILabel!
    
    @IBOutlet var passiveImage: UIImageView!
    @IBOutlet var passiveName: UILabel!
    @IBOutlet var passiveDescription: UILabel!
    
    
    @IBOutlet var championImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passiveName.text = "passive"
        
        let tappedChampion = champion.first(where: {$0.id == "\(id)"})
        
        title = tappedChampion?.name
        
        getInfo(id: id) {result in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    self.championName.text = champion.name
                    self.championTitle.text = champion.title
                    
                    self.passiveName.text = champion.passiveName
                    let passiveImage = self.fetchImageForPassiveSpell(passiveImage: champion.passiveImage)
                    if passiveImage != nil {
                        self.passiveImage.image = passiveImage
                    }
                    self.gettingAttributedText(label: self.passiveDescription, text: champion.passiveDescription)
                   
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
    
    private func fetchImageForPassiveSpell(passiveImage: String) -> UIImage? {
           var imageURL: URL?
           var image: UIImage?

           imageURL = URL(string:"https://ddragon.leagueoflegends.com/cdn/10.9.1/img/passive/\(passiveImage)")
               guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return nil }
                  
               image = UIImage(data: imageData)
                  
           return(image)
    }
    
    private func gettingAttributedText(label: UILabel, text: String) {        
        let htmlData = NSString(string: text).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
        if let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                 options: options,
                                                                 documentAttributes: nil) {
            label.attributedText = attributedString
        } else {
            label.text = text
        }
    }
}
