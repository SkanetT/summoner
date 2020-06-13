//
//  StatusCell.swift
//  LoLProject
//
//  Created by Антон on 10.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    
    let serverName = UILabel()
    let serverStatus = UILabel()
    let indicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = .darkGray
        serverName.translatesAutoresizingMaskIntoConstraints = false
        serverName.textAlignment = .left
        serverName.adjustsFontSizeToFitWidth = true
        serverName.numberOfLines = 2
        serverName.minimumScaleFactor = 0.65
        contentView.addSubview(serverName)
        
        serverName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        serverName.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        serverName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        serverName.trailingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        serverStatus.translatesAutoresizingMaskIntoConstraints = false
        serverStatus.textAlignment = .right
        contentView.addSubview(serverStatus)
        
        serverStatus.leadingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        serverStatus.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        serverStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        serverStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indicator)
        
        indicator.isHidden = false
        indicator.startAnimating()
        indicator.color = .white
        indicator.style = .medium
        
        indicator.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 50).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(server: String) {
        let request = StatusRequest.init(server: server)
        NetworkAPI.shared.dataTask(request: request) {result in
            switch result {
            case.success(let statusData):
                if let status = statusData.services.first?.status {
                    DispatchQueue.main.async {
                        if status == "online" {
                            self.serverStatus.textColor = .green
                        } else {
                            self.serverStatus.textColor = .red
                            
                        }
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.serverStatus.text = status
                    }
                }
            case.failure(let error):
                print(error)
                
            }
        }
    }
}
