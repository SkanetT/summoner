//
//  SummonerViewController.swift
//  LoLProject
//
//  Created by Антон on 05.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerViewController: UIViewController {
    
    @IBOutlet var summonerIconImage: UIImageView!
    @IBOutlet var nameLebel: UILabel!
    @IBOutlet var lvlLabel: UILabel!
    
    var name = ""
    var profileIconId = 0
    var summonerLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLebel.text = name
        lvlLabel.text = "Lvl: \(summonerLevel) "
        summonerIconImage.download(urlString: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/\(String(profileIconId)).png")
       
    }


}
