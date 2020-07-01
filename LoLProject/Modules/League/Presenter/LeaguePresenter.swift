//
//  LeaguePresenter.swift
//  LoLProject
//
//  Created by Антон on 29.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LeaguePresenter: LeaguePresenterInput {
   
    private weak var viewController: LeaguePresenterOutput?
    var rankData: RankData
    
    init(data: RankData) {
        self.rankData = data
    }
    
    func attach(_ viewController: LeaguePresenterOutput) {
        self.viewController = viewController
       }
    
    func viewDidLoad() {
           
       }
}
