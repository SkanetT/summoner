//
//  LeagueController.swift
//  LoLProject
//
//  Created by Антон on 02.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LeagueController: UIViewController {
    
    var tableHandler: LeagueTableHandlerProtocol?
    var presenter: LeaguePresenterInput?
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        segmentedControl.removeAllSegments()
        UserRank.allCases.forEach{
            segmentedControl.insertSegment(withTitle: $0.title, at: segmentedControl.numberOfSegments, animated: false)
        }
        segmentedControl.addTarget(self, action: #selector(didChangeUserTier(_:)), for: .valueChanged)
        
        presenter?.attach(self)
        tableHandler?.attach(tableView)
        presenter?.viewDidLoad()
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor
        
        
        //        if rankData.tier == "GRANDMASTER" || rankData.tier == "MASTER" || rankData.tier == "CHALLENGER" {
        //            segmentedControl.isHidden = true
        //        }
        
        
        tableView.allowsSelection = true
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 8
        
        tableHandler?.setScroll() {[weak self] () in
            
            UIView.animate(withDuration: 0.5, animations: {
                self?.leagueImage.isHidden = true
            })
            
        }
        
    }
    
    @objc
    private func didChangeUserTier( _ sender: UISegmentedControl) {
        presenter?.didSegmentChange(sender.selectedSegmentIndex)
    }
}

extension LeagueController: LeaguePresenterOutput {
    func fetchTitileAndImage(name: String, image: String) {
        title = name
        leagueImage.leagueImage(league: image)
    }
    
    func newTierHasCome(tier: [Entry]) {
        tableHandler?.updateData(tier: tier)
    }
    
    func setAction(userSelect: ((Entry) -> ())?) {
        tableHandler?.setAction(userSelect: userSelect)
    }
    
    func didReciveUserRank(_ rank: UserRank) {
        segmentedControl.selectedSegmentIndex = rank.rawValue
    }
    
    func didReciveTier(tier: [Entry]) {
        tableHandler?.updateData(tier: tier)
    }
}
