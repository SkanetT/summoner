//
//  NoMostPlayedView.swift
//  LoLProject
//
//  Created by Антон on 16.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class NoMostPlayedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let noData = UILabel()
        backgroundColor = .darkGray
        translatesAutoresizingMaskIntoConstraints = false
        noData.translatesAutoresizingMaskIntoConstraints = false
        addSubview(noData)
        noData.textAlignment = .center
        noData.textColor = .systemYellow
        noData.font = UIFont(name: "Avenir", size: 20)
        noData.text = "No data"
        
        noData.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noData.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
