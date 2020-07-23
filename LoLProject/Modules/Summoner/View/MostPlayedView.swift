//
//  MostPlayedView.swift
//  LoLProject
//
//  Created by Антон on 16.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class MostPlayedView: UIView {
    
    let firstMostPlayedChampionImage = UIImageView()
    let firstMostPlayedChampionNameLvl = UILabel()
    let firstMostPlayedChampionPts = UILabel()
    let secondMostPlayedChampionImage = UIImageView()
    let secondMostPlayedChampionNameLvl = UILabel()
    let secondMostPlayedChampionPts = UILabel()
    let thidMostPlayedChampionImage = UIImageView()
    let thidMostPlayedChampionNameLvl = UILabel()
    let thidMostPlayedChampionPts = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        
        firstMostPlayedChampionImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstMostPlayedChampionImage)
        firstMostPlayedChampionImage.contentMode = .scaleAspectFit
        firstMostPlayedChampionImage.clipsToBounds = true
        firstMostPlayedChampionImage.layer.cornerRadius = 4
        firstMostPlayedChampionImage.layer.borderColor = UIColor.white.cgColor
        firstMostPlayedChampionImage.layer.borderWidth = 1.2
        
        firstMostPlayedChampionImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        firstMostPlayedChampionImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70).isActive = true
        firstMostPlayedChampionImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstMostPlayedChampionImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        firstMostPlayedChampionNameLvl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstMostPlayedChampionNameLvl)
        firstMostPlayedChampionNameLvl.contentMode = .left
        firstMostPlayedChampionNameLvl.font = UIFont(name: "Avenir", size: 20)
        
        firstMostPlayedChampionNameLvl.topAnchor.constraint(equalTo: firstMostPlayedChampionImage.topAnchor).isActive = true
        firstMostPlayedChampionNameLvl.leadingAnchor.constraint(equalTo: firstMostPlayedChampionImage.trailingAnchor, constant: 8).isActive = true
        firstMostPlayedChampionNameLvl.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        firstMostPlayedChampionPts.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstMostPlayedChampionPts)
        firstMostPlayedChampionPts.contentMode = .left
        firstMostPlayedChampionPts.font = UIFont(name: "Avenir", size: 16)
        
        firstMostPlayedChampionPts.bottomAnchor.constraint(equalTo: firstMostPlayedChampionImage.bottomAnchor).isActive = true
        firstMostPlayedChampionPts.leadingAnchor.constraint(equalTo: firstMostPlayedChampionImage.trailingAnchor, constant: 8).isActive = true
        firstMostPlayedChampionPts.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        secondMostPlayedChampionImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondMostPlayedChampionImage)
        secondMostPlayedChampionImage.contentMode = .scaleAspectFit
        
        secondMostPlayedChampionImage.topAnchor.constraint(equalTo: firstMostPlayedChampionImage.bottomAnchor, constant: 8).isActive = true
        secondMostPlayedChampionImage.centerXAnchor.constraint(equalTo: firstMostPlayedChampionImage.centerXAnchor).isActive = true
        secondMostPlayedChampionImage.heightAnchor.constraint(equalToConstant: 38).isActive = true
        secondMostPlayedChampionImage.widthAnchor.constraint(equalToConstant: 38).isActive = true
        
        secondMostPlayedChampionImage.clipsToBounds = true
        secondMostPlayedChampionImage.layer.cornerRadius = 4
        secondMostPlayedChampionImage.layer.borderColor = UIColor.white.cgColor
        secondMostPlayedChampionImage.layer.borderWidth = 1.2
        
        secondMostPlayedChampionNameLvl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondMostPlayedChampionNameLvl)
        secondMostPlayedChampionNameLvl.contentMode = .left
        secondMostPlayedChampionNameLvl.font = UIFont(name: "Avenir", size: 17)
        
        secondMostPlayedChampionNameLvl.topAnchor.constraint(equalTo: secondMostPlayedChampionImage.topAnchor).isActive = true
        secondMostPlayedChampionNameLvl.leadingAnchor.constraint(equalTo: firstMostPlayedChampionPts.leadingAnchor).isActive = true
        secondMostPlayedChampionNameLvl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        secondMostPlayedChampionPts.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondMostPlayedChampionPts)
        secondMostPlayedChampionPts.contentMode = .left
        secondMostPlayedChampionPts.font = UIFont(name: "Avenir", size: 15)
        
        secondMostPlayedChampionPts.bottomAnchor.constraint(equalTo: secondMostPlayedChampionImage.bottomAnchor).isActive = true
        secondMostPlayedChampionPts.leadingAnchor.constraint(equalTo: secondMostPlayedChampionNameLvl.leadingAnchor).isActive = true
        secondMostPlayedChampionPts.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        thidMostPlayedChampionImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thidMostPlayedChampionImage)
        thidMostPlayedChampionImage.contentMode = .scaleAspectFit
        
        thidMostPlayedChampionImage.topAnchor.constraint(equalTo: secondMostPlayedChampionImage.bottomAnchor, constant: 8).isActive = true
        thidMostPlayedChampionImage.centerXAnchor.constraint(equalTo: secondMostPlayedChampionImage.centerXAnchor).isActive = true
        thidMostPlayedChampionImage.heightAnchor.constraint(equalToConstant: 38).isActive = true
        thidMostPlayedChampionImage.widthAnchor.constraint(equalToConstant: 38).isActive = true
        
        thidMostPlayedChampionImage.clipsToBounds = true
        thidMostPlayedChampionImage.layer.cornerRadius = 4
        thidMostPlayedChampionImage.layer.borderColor = UIColor.white.cgColor
        thidMostPlayedChampionImage.layer.borderWidth = 1.2
        
        thidMostPlayedChampionNameLvl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thidMostPlayedChampionNameLvl)
        thidMostPlayedChampionNameLvl.contentMode = .left
        thidMostPlayedChampionNameLvl.font = UIFont(name: "Avenir", size: 17)
        
        thidMostPlayedChampionNameLvl.topAnchor.constraint(equalTo: thidMostPlayedChampionImage.topAnchor).isActive = true
        thidMostPlayedChampionNameLvl.leadingAnchor.constraint(equalTo: secondMostPlayedChampionPts.leadingAnchor).isActive = true
        thidMostPlayedChampionNameLvl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        thidMostPlayedChampionPts.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thidMostPlayedChampionPts)
        thidMostPlayedChampionPts.contentMode = .left
        thidMostPlayedChampionPts.font = UIFont(name: "Avenir", size: 15)
        
        thidMostPlayedChampionPts.bottomAnchor.constraint(equalTo: thidMostPlayedChampionImage.bottomAnchor).isActive = true
        thidMostPlayedChampionPts.leadingAnchor.constraint(equalTo: thidMostPlayedChampionNameLvl.leadingAnchor).isActive = true
        thidMostPlayedChampionPts.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func setData(mostPlayedChampions: MostPlayedChampionsData) {
        guard let firstChampion = RealmManager.fetchChampionfromKey(mostPlayedChampions[0].championId.description), let secondChampion = RealmManager.fetchChampionfromKey(mostPlayedChampions[1].championId.description), let thidChampion = RealmManager.fetchChampionfromKey(mostPlayedChampions[2].championId.description) else { return }
        
        self.firstMostPlayedChampionNameLvl.text = "\(firstChampion.name) \(mostPlayedChampions[0].championLevel) lvl"
        self.firstMostPlayedChampionPts.text = "\(mostPlayedChampions[0].championPoints) pts"
        
        self.firstMostPlayedChampionImage.downloadSD(type: .championIcon(id: firstChampion.id))
        
        
        self.secondMostPlayedChampionNameLvl.text = "\(secondChampion.name) \(mostPlayedChampions[1].championLevel) lvl"
        self.secondMostPlayedChampionPts.text = "\(mostPlayedChampions[1].championPoints) pts"
        
        self.secondMostPlayedChampionImage.downloadSD(type: .championIcon(id: secondChampion.id))
        
        
        self.thidMostPlayedChampionNameLvl.text = "\(thidChampion.name) \(mostPlayedChampions[2].championLevel) lvl"
        self.thidMostPlayedChampionPts.text = "\(mostPlayedChampions[2].championPoints) pts"
        
        self.thidMostPlayedChampionImage.downloadSD(type: .championIcon(id: thidChampion.id))
    }
}

