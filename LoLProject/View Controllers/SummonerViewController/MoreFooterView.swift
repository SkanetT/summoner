//
//  MoreFooterView.swift
//  LoLProject
//
//  Created by Антон on 17.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class MoreFooterView: UIView {
    
    let moreButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        backgroundColor = .darkGray
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moreButton)
        
        moreButton.alpha = 0.5
        moreButton.backgroundColor = .blue
        moreButton.setTitle("More matchs", for: .normal)
        moreButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        moreButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
