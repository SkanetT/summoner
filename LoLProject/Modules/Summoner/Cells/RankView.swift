//
//  RankView.swift
//  LoLProject
//
//  Created by Антон on 14.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class RankView: UIView {
    
    let flexName = UILabel()
    let soloName = UILabel()
    let flexRank = UILabel()
    let soloRank = UILabel()
    let flexImage = UIImageView()
    let soloImage = UIImageView()
    let flexWr = UILabel()
    let soloWr = UILabel()
    let separator = UIView()
    let bottom = UIView()
    let wallpaper = UIView()
    let wallpaper2 = UIView()

    var tapHandler: ( (String)->() )?
    var leagueIdSolo: String = "0"
    var leagueIdFlex: String = "0"

    
    @objc func tappedOnSoloLeague() {
        tapHandler?(leagueIdSolo)
    }
    
    @objc func tappedOnFlexLeague() {
        tapHandler?(leagueIdFlex)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        wallpaper.backgroundColor = .lightGray
        wallpaper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wallpaper)
        wallpaper.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        wallpaper.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wallpaper.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        wallpaper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        wallpaper.clipsToBounds = true
        wallpaper.layer.cornerRadius = 10
        wallpaper.layer.borderWidth = 2
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        
        separator.backgroundColor = .black
        separator.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        separator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        flexName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flexName)
        
        flexName.font = UIFont(name: "Avenir-Heavy", size: 22)
        flexName.textAlignment = .center
        flexName.text = "Flex"
        flexName.textColor = .systemYellow
        flexName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        flexName.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -90).isActive = true
        flexName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        flexName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        soloName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(soloName)
        
        soloName.font = UIFont(name: "Avenir-Heavy", size: 22)
        soloName.textAlignment = .center
        soloName.text = "Solo"
        soloName.textColor = .systemYellow
        soloName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        soloName.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 90).isActive = true
        soloName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        soloName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        flexRank.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flexRank)
        
        flexRank.font = UIFont(name: "Avenir-Heavy", size: 17)
        flexRank.textAlignment = .center
        flexRank.adjustsFontSizeToFitWidth = true
        flexRank.minimumScaleFactor = 0.7
        flexRank.text = "Unranked"
        flexRank.textColor = .black
        flexRank.topAnchor.constraint(equalTo: flexName.bottomAnchor, constant: 8).isActive = true
        flexRank.centerXAnchor.constraint(equalTo: flexName.centerXAnchor, constant: 0).isActive = true
        flexRank.widthAnchor.constraint(equalToConstant: 150).isActive = true
        flexRank.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        soloRank.translatesAutoresizingMaskIntoConstraints = false
        addSubview(soloRank)
        
        soloRank.font = UIFont(name: "Avenir-Heavy", size: 17)
        soloRank.textAlignment = .center
        soloRank.adjustsFontSizeToFitWidth = true
        soloRank.minimumScaleFactor = 0.7
        soloRank.text = "Unranked"
        soloRank.textColor = .black
        soloRank.topAnchor.constraint(equalTo: soloName.bottomAnchor, constant: 8).isActive = true
        soloRank.centerXAnchor.constraint(equalTo: soloName.centerXAnchor, constant: 0).isActive = true
        soloRank.widthAnchor.constraint(equalToConstant: 150).isActive = true
        soloRank.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        flexImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flexImage)
        
        flexImage.image = #imageLiteral(resourceName: "Unranked")
        flexImage.contentMode = .scaleAspectFit
        flexImage.topAnchor.constraint(equalTo: flexRank.bottomAnchor, constant: 8).isActive = true
        flexImage.centerXAnchor.constraint(equalTo: flexRank.centerXAnchor, constant: 0).isActive = true
        flexImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        flexImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        soloImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(soloImage)
        
        soloImage.image = #imageLiteral(resourceName: "Unranked")
        soloImage.contentMode = .scaleAspectFit
        soloImage.topAnchor.constraint(equalTo: soloRank.bottomAnchor, constant: 8).isActive = true
        soloImage.centerXAnchor.constraint(equalTo: soloRank.centerXAnchor, constant: 0).isActive = true
        soloImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        soloImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        flexWr.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flexWr)
        
        flexWr.font = UIFont(name: "Avenir", size: 17)
        flexWr.textAlignment = .center
        flexWr.text = ""
        flexWr.textColor = .black
        flexWr.topAnchor.constraint(equalTo: flexImage.bottomAnchor, constant: 8).isActive = true
        flexWr.centerXAnchor.constraint(equalTo: flexImage.centerXAnchor, constant: 0).isActive = true
        flexWr.widthAnchor.constraint(equalToConstant: 90).isActive = true
        flexWr.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        soloWr.translatesAutoresizingMaskIntoConstraints = false
        addSubview(soloWr)
        
        soloWr.font = UIFont(name: "Avenir", size: 17)
        soloWr.textAlignment = .center
        soloWr.text = ""
        soloWr.textColor = .black
        soloWr.topAnchor.constraint(equalTo: soloImage.bottomAnchor, constant: 8).isActive = true
        soloWr.centerXAnchor.constraint(equalTo: soloImage.centerXAnchor, constant: 0).isActive = true
        soloWr.widthAnchor.constraint(equalToConstant: 90).isActive = true
        soloWr.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
    }
    
    func setData(leagueData: LeagueData) {
        
        
        if let flexRankData = leagueData.first(where: {$0.queueType == "RANKED_FLEX_SR"}) {
           
            leagueIdFlex = flexRankData.leagueId
            
            DispatchQueue.main.async {
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnFlexLeague))
                self.flexImage.addGestureRecognizer(tap)
                self.flexImage.isUserInteractionEnabled = true
                
            }
            
            let wrFlex :Double
            wrFlex = Double(flexRankData.wins) / (Double(flexRankData.wins) + Double(flexRankData.losses)) * 100
            DispatchQueue.main.async {
                self.flexRank.text = "\(flexRankData.tier) \(flexRankData.rank) (LP \(flexRankData.leaguePoints))"
                if wrFlex < 50 {
                    self.flexWr.textColor = .red
                } else {
                    self.flexWr.textColor = .green
                }
                self.flexWr.text = "WR \(round(10*wrFlex)/10)%"
                
                self.flexImage.leagueImage(league: flexRankData.tier)
            }
        }
        if let soloRankData = leagueData.first(where: {$0.queueType == "RANKED_SOLO_5x5"}) {
           
            leagueIdSolo = soloRankData.leagueId

            
            DispatchQueue.main.async {
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnSoloLeague))
                self.soloImage.addGestureRecognizer(tap)
                self.soloImage.isUserInteractionEnabled = true
                
            }
            

            
            let wrSolo :Double
            wrSolo = Double(soloRankData.wins) / (Double(soloRankData.wins) + Double(soloRankData.losses)) * 100
            DispatchQueue.main.async {
                if wrSolo < 50 {
                    self.soloWr.textColor = .red
                } else {
                    self.soloWr.textColor = .green
                }
                
                
                self.soloWr.text = "WR \(round(10*wrSolo)/10)%"
                self.soloRank.text = "\(soloRankData.tier) \(soloRankData.rank) (LP \(soloRankData.leaguePoints))"
                
                self.soloImage.leagueImage(league: soloRankData.tier)
            }
        }
    }
}

