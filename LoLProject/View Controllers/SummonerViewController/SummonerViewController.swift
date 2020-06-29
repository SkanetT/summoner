//
//  SummonerViewController.swift
//  LoLProject
//
//  Created by Антон on 05.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class SummonerViewController: SpinnerController {
    
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
    
    let dataQueue: DispatchQueue = DispatchQueue.init(label: "qqq", qos: .userInteractive)
    
    weak var delegate: LoginControllerDelegate?
    
    let header = RankView()
    let footer = MoreFooterView()
    
    var matchsArray: [ExpandableMathHistory] = []
    
    let champions = try! Realm().objects(Champion.self)
    let spells = try! Realm().objects(SummonerSpell.self)
    let foundSummoner = RealmManager.fetchFoundSummoner()
    let saveSummoner = RealmManager.fetchSaveSummoner()
    
    var matchModel: [MatchModel] = []
    
    var topWallpapperIndex = 0
    
    var spectatorData: SpectatorDate?
    
    @objc private func refresh(sender: UIRefreshControl){
        dismiss(animated: true)
        sender.endRefreshing()
    }
    
    
    @objc func handleMenu(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        guard let foundSummoner = foundSummoner else { return }
        
        fetcSpectator(summonerId: foundSummoner.id, server: foundSummoner.region)
        setupUI()
        configureSaveBitton()
        tableViewConfiguration()
        
        title = "\(foundSummoner.name) (\(foundSummoner.region))"
        lvlLabel.text = "Lvl: \(foundSummoner.summonerLevel) "
        
        summonerIconImage.downloadSD(type: .profileIcon(id: foundSummoner.profileIconId.description))
        
        fetchMatchHistory(summonerName: foundSummoner.name, summonerId: foundSummoner.id, accountId: foundSummoner.accountId, server: foundSummoner.region)
        
        fetchMostPlayedChampions(summonerId: foundSummoner.id, server: foundSummoner.region)
    }
    
    func fetchMatchHistory(summonerName: String, summonerId: String, accountId: String, server: String) {
        let matchHistoryRequest = MatchHistoryRequest.init(accountId: accountId, server: server)
        
        NetworkAPI.shared.dataTask(request: matchHistoryRequest) {[weak self] result in
            
            guard let self = self else{ return }
            switch result {
            case .success(let matchs):
                
                self.matchsArray = matchs.matches.map{ .init(isExpanded: false, match: $0) }
                
                self.matchHistoryLoad(region: server, summonerName: summonerName, summonerId: summonerId)
                
            case .failure(let error):
                self.showErrorMessage(error)
                self.removeSpinner()
                
            }
        }
    }
    
    func fetchMostPlayedChampions(summonerId: String, server: String) {
        let mostPlayedChampionsRequest = MostPlayedChampionsRequest.init(summonerId: summonerId, server: server)
        
        NetworkAPI.shared.dataTask(request: mostPlayedChampionsRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let mostPlayedChampions):
                
                if mostPlayedChampions.count >= 3 {
                    DispatchQueue.main.async {
                        
                        self.indicator.isHidden = true
                        self.indicator.stopAnimating()
                        let mostView = MostPlayedView()
                        mostView.setData(mostPlayedChampions: mostPlayedChampions)
                        self.mostPlayed.addSubview(mostView)
                        mostView.leadingAnchor.constraint(equalTo: self.mostPlayed.leadingAnchor).isActive = true
                        mostView.trailingAnchor.constraint(equalTo: self.mostPlayed.trailingAnchor).isActive = true
                        mostView.topAnchor.constraint(equalTo: self.mostPlayed.topAnchor).isActive = true
                        mostView.bottomAnchor.constraint(equalTo: self.mostPlayed.bottomAnchor).isActive = true
                    }
                } else {
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
            case.failure:
                print("No most Played")
            }
        }
    }

    func tableViewConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: "MatchHistoryCell", bundle: nil), forCellReuseIdentifier: "mach")
        tableView.register(UINib(nibName: "MoreInfoCell", bundle: nil), forCellReuseIdentifier: "moreInfo")
    }
    
    func setupUI() {
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        summonerTopButton.isHidden = true
        summonerTopButton.clipsToBounds = true
        summonerTopButton.layer.cornerRadius = 35
        summonerTopButton.layer.borderColor = UIColor.black.cgColor
        summonerTopButton.layer.borderWidth = 1.5
        summonerTopButton.layer.shadowColor = UIColor.black.cgColor
        summonerTopButton.layer.masksToBounds = false
        summonerTopButton.layer.shadowRadius = 3
        summonerTopButton.layer.shadowOpacity = 0.5
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 35
        saveButton.layer.borderColor = UIColor.black.cgColor
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
        
        indicator.isHidden = false
        indicator.startAnimating()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .default
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    
    func configureSaveBitton() {
        guard let foundSummoner = foundSummoner, let saveSummoner = saveSummoner else { return }
        if foundSummoner.id == saveSummoner.id {
            saveButton.isHidden = true
        } else {
            saveButton.isHidden = false
        }
        
    }
    
    @objc
    func spectatorPresent() {
        guard spectatorData != nil else { return }
        let vc = SpectatorController()
        vc.spectatorDate = spectatorData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func saveSummoner(_ sender: Any ) {
        guard let foundSummoner = foundSummoner, let saveSummoner = saveSummoner else { return }
        if foundSummoner.id != saveSummoner.id {
            let ac = UIAlertController(title: "\(foundSummoner.name) will save", message: "\(saveSummoner.name) will delete", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) {[weak self]_ in
                
                RealmManager.reWriteSaveSummoner()
                self?.dismiss(animated: true, completion: nil)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(ok)
            ac.addAction(cancel)
            present(ac, animated: true)
            
            
        }
    }
    
    @IBAction func showTop(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.topWallpaper.isHidden = false
            self.summonerTopButton.isHidden = true
        })
    }
    
    
    
    
    
    func fetcSpectator(summonerId: String, server: String) {
        let spectatorRequest = SpectatorRequest.init(summonerId: summonerId, server: server)
        
        
        NetworkAPI.shared.dataTask(request: spectatorRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let spectatorDate):
                
                
                self.spectatorData = spectatorDate
                DispatchQueue.main.async {
                    
                    self.statusLabel.flash()
                    
                    
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(self.spectatorPresent))
                    
                    self.statusLabel.addGestureRecognizer(gesture)
                    self.statusLabel.isUserInteractionEnabled = true
                    
                    self.statusLabel.backgroundColor = .green
                    
                    self.statusLabel.text = "Online"
                }
                
                
            case.failure(let error):
                switch error {
                case.noData:
                    DispatchQueue.main.async {
                        self.statusLabel.backgroundColor = .red
                        self.statusLabel.text = "Offline"
                    }
                case .statusCode(_):
                    print(error)
                case .network:
                    print(error)
                case .parsing:
                    print(error)
                case .unknown:
                    print(error)
                case .noInternet:
                    print(error)
                }
            }
        }
    }
    
}

extension SummonerViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchsArray[section].isExpanded ? 2 : 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let matchHistoryCell = tableView.dequeueReusableCell(withIdentifier: "mach", for: indexPath) as! MatchHistoryCell
        let moreInfoCell = tableView.dequeueReusableCell(withIdentifier: "moreInfo", for: indexPath) as! MoreInfoCell
        
        let matchForSection = matchModel[indexPath.section]
        
        matchHistoryCell.clipsToBounds = true
        matchHistoryCell.layer.cornerRadius = 6
        moreInfoCell.clipsToBounds = true
        moreInfoCell.layer.cornerRadius = 6
        
        matchHistoryCell.setData(summonerInMatch: matchForSection.summonerInMatch)
        
        if matchForSection.members.count == 10 {
            
            moreInfoCell.setDataForEnvironment(summonerIdInGame: matchForSection.summonerInMatch.idInMatch, win: matchForSection.summonerInMatch.win)
            moreInfoCell.setDataForParticipants(members: matchForSection.members.self)
            
            
        }
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                matchHistoryCell.tapHandler = { [weak self]  in
                    guard let self = self else { return }
                    self.matchsArray[indexPath.section].isExpanded.toggle()
                    self.tableView.reloadData()
                }
                
            }
            return matchHistoryCell
        } else {
            return moreInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let summoner = try! Realm().objects(FoundSummoner.self)
        guard let foundSummoner = summoner.first else { return nil }
        if section == 0 {
            
            let leagueRequest = LeagueRequest.init(summonerId: foundSummoner.id, server: foundSummoner.region)
            
            NetworkAPI.shared.dataTask(request: leagueRequest) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let leagueData):
                    self.header.setData(leagueData: leagueData)
                case.failure:
                    print("no league")
                }
                
            }
            
            header.tapHandler = {[weak self] value in
                
                let req = RankRequest(leagueId: value, server: foundSummoner.region)
                
                NetworkAPI.shared.dataTask(request: req) {[weak self] result in
                    switch result{
                    case.success(let rankData):
                        DispatchQueue.main.async {
                            let leagueVC = LeagueAssembler.createModule(rankData)
                            self?.navigationController?.pushViewController(leagueVC, animated: true)
                        }
                    case .failure:
                        print("!!!!!!!!")
                    }
                }
            }
            return header
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 280 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section >= topWallpapperIndex + 5 || indexPath.section <= topWallpapperIndex - 5   {
            if self.topWallpaper.isHidden == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.topWallpaper.isHidden = true
                self.summonerTopButton.isHidden = false
            }, completion: { _ in
                self.topWallpapperIndex = indexPath.section
            })
            }
        }
        
        guard let foundSummoner = foundSummoner else { return }
        guard indexPath.section == matchModel.count - 6 else { return }
        matchHistoryLoad(region: foundSummoner.region, summonerName: foundSummoner.name, summonerId: foundSummoner.id)
        
    }
    
    private func reloadMatchInfo(disGroup: DispatchGroup, matchId: Int,region: String, reply: Int = 0, summonerName: String, summonerId: String ) {
        guard reply < 4 else {
            print("not reload 🧻")
            disGroup.leave()
            return
        }
        
        let fullInfoMatch = FullInfoMatchRequest.init(matchId: String(matchId), server: region)
        
        NetworkAPI.shared.dataTask(request: fullInfoMatch) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let fullMatchHistory):
                self.dataQueue.sync(flags:.barrier) {
                    print("reload 🩸")
                    disGroup.leave()
                    let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName, summonerId: summonerId, handler: {[weak self] str in
                        self?.relogin(name: str)
                    })
                    self.matchModel.append(match)
                }
            case.failure:
                self.reloadMatchInfo(disGroup: disGroup, matchId: matchId, region: region, reply: reply + 1, summonerName: summonerName, summonerId: summonerId)
            }
        }
    }
    
    private func matchHistoryLoad(region : String, summonerName: String, summonerId: String) {
        let disGroup = DispatchGroup()
        var failsMatchs = 0
        
        let decValue = matchsArray.count - matchModel.count < 7 ? matchsArray.count - matchModel.count - 1 : 7
        guard decValue > 1 else { return }
        
        for i in matchModel.count...(matchModel.count + decValue) {
            
            disGroup.enter()
            
            let fullInfoMatch = FullInfoMatchRequest.init(matchId: String(self.matchsArray[i].match.gameId), server: region)
            
            NetworkAPI.shared.dataTask(request: fullInfoMatch) {[weak self] result in
                guard let self = self else { return }
                
                switch result {
                case.success(let fullMatchHistory):
                    self.dataQueue.sync(flags:.barrier) {
                        disGroup.leave()
                        let match: MatchModel = .init(match: fullMatchHistory, summonerName: summonerName, summonerId: summonerId, handler: {[weak self] str in
                            self?.relogin(name: str)
                        })
                        self.matchModel.append(match)
                    }
                case.failure(let erorr):
                    print("####",erorr)
                    print("Fail section \(i) for match \(self.matchsArray[i].match.gameId)")
                    failsMatchs += 1
                    self.reloadMatchInfo(disGroup: disGroup, matchId: self.matchsArray[i].match.gameId, region: region, summonerName: summonerName, summonerId: summonerId)
                }
            }
        }
        
        disGroup.notify(queue: .main) {[weak self] in
            guard let self = self else { return }
            self.matchModel.sort { (lhs, rhs) -> Bool in
                return lhs.summonerInMatch.dateCreation > rhs.summonerInMatch.dateCreation
            }
            if failsMatchs != 0 {
                print (" 💡💡💡💡💡💡 Fails ⚰️ \(failsMatchs) ⚰️ 💡💡💡💡💡💡 ")
            } else {
                print("🌈🌈🌈🌈🌈🌈 All matchs good 🌈🌈🌈🌈🌈🌈")
            }
            self.tableView.reloadData()
            self.removeSpinner()
        }
    }
    
    private func relogin(name: String) {
        guard let foundSummoner = foundSummoner else { return }
        if name != foundSummoner.name {

            let server = foundSummoner.region
            let request = SummonerRequest(summonerName: name, server: server)
            NetworkAPI.shared.dataTask(request: request) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let summonerData):
                    DispatchQueue.main.async {
                        RealmManager.reWriteFoundSummoner(summonerData)
                        self.dismiss(animated: true, completion: nil)
                    }
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
}


