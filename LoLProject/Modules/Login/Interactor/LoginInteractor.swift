//
//  LoginInteractor.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInput {
    
    private weak var output: LoginInteractorOutput?
    
    func attach(_ output: LoginInteractorOutput) {
        self.output = output
    }
    
    func checkSummoner() {
        let summoner = RealmManager.fetchFoundSummoner()
        if summoner != nil {
            output?.isLogin()
        }
    }
    
    func foundSummoner(_ name: String, _ region: String) {
        
        let summonerRequest = SummonerRequest(summonerName: name
            , server: region)
        
        NetworkAPI.shared.dataTask(request: summonerRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let summonerData):
                DispatchQueue.main.async {
                    RealmManager.loginSummoner(summonerData: summonerData, region: region)
                    self.output?.successFoundSummoner()
                }
            case.failure(let error):
                switch error {
                case .noData:
                    self.output?.successNoSummoner(name)
                case .statusCode(_), .network, .parsing, .unknown ,.noInternet:
                    self.output?.failureSummoner(error)
                }
            }
        }
    }
}
