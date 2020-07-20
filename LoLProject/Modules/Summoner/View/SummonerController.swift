//
//  SummonerViewController.swift
//  LoLProject
//
//  Created by Антон on 05.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerController: SpinnerController {
    
    @IBOutlet weak var mostPlayed: UIView!
    @IBOutlet weak var topWallpaper: UIView!
    @IBOutlet weak var summonerIconImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var summonerTopButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
        
    var presenter: SummonerPresenterInput?
    var tableHandler: SummonerTableHandlerProtocol?
    
    @objc func handleMenu(){
        presenter?.sideMenuTap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        
        presenter?.attach(self)
        presenter?.viewDidLoad()
        tableHandler?.attach(tableView)
        setupUI()
        
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableHandler?.hideTop() {[weak self] index in
            guard let self = self else { return }
            if self.topWallpaper.isHidden == false {
                UIView.animate(withDuration: 0.5, animations: {
                    self.topWallpaper.isHidden = true
                    self.summonerTopButton.isHidden = false
                }, completion: { _ in
                    self.tableHandler?.updateIndex(index)
                })
            }
        }
    }
    
    private func setupUI() {
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        summonerTopButton.isHidden = true
        summonerTopButton.clipsToBounds = true
        summonerTopButton.layer.cornerRadius = 35
        summonerTopButton.layer.borderColor = UIColor.white.cgColor
        summonerTopButton.layer.borderWidth = 1.5
        summonerTopButton.layer.shadowColor = UIColor.black.cgColor
        summonerTopButton.layer.masksToBounds = false
        summonerTopButton.layer.shadowRadius = 3
        summonerTopButton.layer.shadowOpacity = 0.5
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 35
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 1.5
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.masksToBounds = false
        saveButton.layer.shadowRadius = 3
        saveButton.layer.shadowOpacity = 0.5
        
        summonerIconImage.clipsToBounds = true
        summonerIconImage.layer.cornerRadius = 50
        summonerIconImage.layer.borderColor = UIColor.white.cgColor
        summonerIconImage.layer.borderWidth = 3
        topWallpaper.backgroundColor = .lightGray
        topWallpaper.clipsToBounds = true
        topWallpaper.layer.cornerRadius = 10
        topWallpaper.layer.borderWidth = 2
        statusLabel.clipsToBounds = true
        statusLabel.layer.cornerRadius = 4
        statusLabel.layer.backgroundColor = UIColor.black.cgColor
        statusLabel.layer.borderWidth = 1.5
        
        lvlLabel.layer.cornerRadius = 4
        lvlLabel.layer.borderColor = UIColor.white.cgColor
        lvlLabel.layer.borderWidth = 1.25
        
        indicator.isHidden = false
        indicator.startAnimating()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .default
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    
    @objc
    func spectatorPresent() {
        presenter?.spectatorDidTap()
    }
    
    
    @IBAction func saveSummoner(_ sender: Any ) {
        presenter?.saveTap()
    }
    
    @IBAction func showTop(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.topWallpaper.isHidden = false
            self.summonerTopButton.isHidden = true
        })
    }
}

extension SummonerController: SummonerPresenterOutput {
    func leagueTaped(_ league: ((String) -> ())?) {
        tableHandler?.setLeague(league)
    }
    
    func didReceiveLeague(_ data: LeagueData) {
        tableHandler?.setDataForHeader(data)
    }
    
    func dataForTable(_ matchModel: [MatchModel]) {
        tableHandler?.updateData(matchModel)
    }
    
    func scrollingDown(_ reload: (() -> ())?) {
        tableHandler?.setUpgrade(reload)
    }
    
    func noDataForTable() {
        removeSpinner()
    }
    
    func firstDataForTable(matchsArray: [ExpandableMathHistory], matchModel: [MatchModel]) {
        removeSpinner()
        tableHandler?.setStartData(matchsArray: matchsArray, matchModel: matchModel)
    }
    
    func summonerOnline() {
        DispatchQueue.main.async {
            
            self.statusLabel.flash()
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.spectatorPresent))
            
            self.statusLabel.addGestureRecognizer(gesture)
            self.statusLabel.isUserInteractionEnabled = true
            
            self.statusLabel.backgroundColor = .green
            
            self.statusLabel.text = "Online"
        }
    }
    
    func summomerOffline() {
        DispatchQueue.main.async {
            self.statusLabel.backgroundColor = .red
            self.statusLabel.text = "Offline"
        }
    }
    
    func isSaveSummoner(_ isSaveSummoner: Bool) {
        if isSaveSummoner {
            saveButton.isHidden = true
        } else {
            saveButton.isHidden = false
        }
    }
    
    func didReceiveDataForSummoner(_ name: String, _ region: String, _ level: String, _ profileId: String) {
        title = "\(name) (\(region))"
        lvlLabel.text = "Lvl: \(level) "
        
        summonerIconImage.downloadSD(type: .profileIcon(id: profileId))
        
    }
    
    func didReceiveMostPlayedView(_ data: MostPlayedChampionsData) {
        
        DispatchQueue.main.async {
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            let mostView = MostPlayedView()
            mostView.setData(mostPlayedChampions: data)
            self.mostPlayed.addSubview(mostView)
            mostView.leadingAnchor.constraint(equalTo: self.mostPlayed.leadingAnchor).isActive = true
            mostView.trailingAnchor.constraint(equalTo: self.mostPlayed.trailingAnchor).isActive = true
            mostView.topAnchor.constraint(equalTo: self.mostPlayed.topAnchor).isActive = true
            mostView.bottomAnchor.constraint(equalTo: self.mostPlayed.bottomAnchor).isActive = true
        }
    }
    
    func didReceiveNoMostPlayedView() {
        
        DispatchQueue.main.async {
            
            let noData = NoMostPlayedView()
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.mostPlayed.addSubview(noData)
            noData.leadingAnchor.constraint(equalTo: self.mostPlayed.leadingAnchor).isActive = true
            noData.trailingAnchor.constraint(equalTo: self.mostPlayed.trailingAnchor).isActive = true
            noData.topAnchor.constraint(equalTo: self.mostPlayed.topAnchor).isActive = true
            noData.bottomAnchor.constraint(equalTo: self.mostPlayed.bottomAnchor).isActive = true
        }
    }
}
