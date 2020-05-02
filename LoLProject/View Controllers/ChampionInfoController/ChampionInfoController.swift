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
               //     self.passiveDescription.text = champion.passiveDescription
                    
                    let htmlData = NSString(string: champion.passiveDescription).data(using: String.Encoding.unicode.rawValue)
                    let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html]
                    if let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                             options: options,
                                                                             documentAttributes: nil) {
                        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 11), range: NSMakeRange(0, attributedString.string.count))
                        self.passiveDescription.attributedText = attributedString
                    } else {
                        print("nope")
                      //  label.text = "строка"
                    }
                    
                    
                    let imagePassive = self.fetchImageForPassiveSpell(passiveImage: champion.passiveImage)
                    
                    if imagePassive != nil {
                        self.passiveImage.image = imagePassive
                    }
                }
               
            case .failure:
                print("Errort")
            }
        }
//        championName.text = tappedChampion?.name
//        championTitle.text = tappedChampion?.title
        
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
}
