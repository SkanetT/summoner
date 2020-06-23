//
//  MenuController.swift
//  LoLProject
//
//  Created by Антон on 06.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifer = "MenuOptionCell"

class MenuController: UIViewController {
    
    let saveSummoner = try! Realm().objects(SaveSummoner.self)
    let foundSummoner = try! Realm().objects(FoundSummoner.self)
    
    var tableView: UITableView!
    var botPlace: UIView!
    var logOut: UIButton!
    var swap: UIButton!
    var saveSummonerIcon: UIImageView!
    var saveSummonerName: UILabel!
    weak var delegate: LoginControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMenu()
        view.backgroundColor = .gray
        
        if saveSummoner.isEmpty {
            botPlace.isHidden = true
        } else {
            botPlace.isHidden = false
            setDataToBot()
        }
        
        
        
    }
    
    func configureMenu(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        
        logOut = UIButton()
        logOut.setTitle("Log out", for: .normal)
        logOut.setTitleColor(.black, for: .normal)
        logOut.backgroundColor = .red
        logOut.alpha = 0.9
        logOut.clipsToBounds = true
        logOut.layer.cornerRadius = 8
        logOut.layer.borderColor = UIColor.white.cgColor
        logOut.layer.borderWidth = 1
        
        swap = UIButton()
        swap.setTitle("Swap", for: .normal)
        swap.setTitleColor(.black, for: .normal)
        swap.backgroundColor = .green
        swap.alpha = 0.9
        swap.clipsToBounds = true
        swap.layer.cornerRadius = 8
        swap.layer.borderColor = UIColor.white.cgColor
        swap.layer.borderWidth = 1
        
        
        botPlace = UIView()
        botPlace.backgroundColor = .gray
        botPlace.clipsToBounds = true
        botPlace.layer.cornerRadius = 8
        botPlace.layer.borderColor = UIColor.white.cgColor
        botPlace.layer.borderWidth = 1
        
        
        saveSummonerIcon = UIImageView()
        saveSummonerIcon.clipsToBounds = true
        saveSummonerIcon.layer.cornerRadius = 25
        saveSummonerIcon.layer.borderColor = UIColor.white.cgColor
        saveSummonerIcon.layer.borderWidth = 1
        
        saveSummonerName = UILabel()
        saveSummonerName.font = UIFont(name: "Avenir", size: 20)
        saveSummonerName.textColor = .white
        saveSummonerName.textAlignment = .left
        saveSummonerName.adjustsFontSizeToFitWidth = true
        saveSummonerName.minimumScaleFactor = 0.7
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -149).isActive = true
        
        view.addSubview(botPlace)
        botPlace.translatesAutoresizingMaskIntoConstraints = false
        botPlace.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        botPlace.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8).isActive = true
        botPlace.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -88).isActive = true
        botPlace.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -8).isActive = true
        
        botPlace.addSubview(saveSummonerIcon)
        saveSummonerIcon.translatesAutoresizingMaskIntoConstraints = false
        saveSummonerIcon.topAnchor.constraint(equalTo: botPlace.topAnchor, constant: 8).isActive = true
        saveSummonerIcon.leadingAnchor.constraint(equalTo: botPlace.leadingAnchor, constant: 8).isActive = true
        saveSummonerIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveSummonerIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        botPlace.addSubview(saveSummonerName)
        saveSummonerName.translatesAutoresizingMaskIntoConstraints = false
        saveSummonerName.centerYAnchor.constraint(equalTo: saveSummonerIcon.centerYAnchor).isActive = true
        saveSummonerName.leadingAnchor.constraint(equalTo: saveSummonerIcon.trailingAnchor, constant: 8).isActive = true
        saveSummonerName.trailingAnchor.constraint(equalTo: botPlace.trailingAnchor, constant: -8).isActive = true
        
        
        
        botPlace.addSubview(logOut)
        logOut.translatesAutoresizingMaskIntoConstraints = false
        logOut.topAnchor.constraint(equalTo: saveSummonerIcon.bottomAnchor, constant: 8).isActive = true
        logOut.leadingAnchor.constraint(equalTo: botPlace.leadingAnchor, constant: 8).isActive = true
        logOut.trailingAnchor.constraint(equalTo: botPlace.trailingAnchor, constant: -8).isActive = true
        logOut.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        botPlace.addSubview(swap)
        swap.translatesAutoresizingMaskIntoConstraints = false
        swap.topAnchor.constraint(equalTo: logOut.bottomAnchor, constant: 8).isActive = true
        swap.leadingAnchor.constraint(equalTo: botPlace.leadingAnchor, constant: 8).isActive = true
        swap.trailingAnchor.constraint(equalTo: botPlace.trailingAnchor, constant: -8).isActive = true
        swap.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
    
    func setDataToBot() {
        guard !saveSummoner.isEmpty else { return }
        guard let summoner = saveSummoner.first, let found = foundSummoner.first else { return }
        saveSummonerIcon.downloadSD(type: .profileIcon(id: summoner.profileIconId.description))
        saveSummonerName.text = "\(summoner.name) (\(summoner.region))"
        
        if summoner.name == found.name {
        swap.setTitle("Refresh", for: .normal)
        }
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        
        cell.selectionStyle = .none
        
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
}

