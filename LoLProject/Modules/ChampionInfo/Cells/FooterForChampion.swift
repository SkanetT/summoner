//
//  FooterForChampion.swift
//  LoLProject
//
//  Created by Антон on 31.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class FooterForChampion: UIView {
    
    let loreTitle = UILabel()
    let lore = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .darkGray

        loreTitle.text = "Lore"
        loreTitle.textAlignment = .center
        loreTitle.font = UIFont(name: "Avenir", size: 25)
        
        loreTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loreTitle)
        loreTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loreTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loreTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        lore.text = ""
        lore.textAlignment = .center
        lore.font = UIFont(name: "Avenir", size: 16)
        lore.numberOfLines = 0
        lore.adjustsFontSizeToFitWidth = true
        lore.minimumScaleFactor = 0.3
        
        
        lore.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lore)
        
        lore.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        lore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        lore.topAnchor.constraint(equalTo: loreTitle.bottomAnchor, constant: 6).isActive = true
        lore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true

    }
    
    func setData(lore: String) {
        DispatchQueue.main.async {
            self.lore.text = lore
        }
    }
}
