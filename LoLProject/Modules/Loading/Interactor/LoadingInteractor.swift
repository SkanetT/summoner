//
//  LoadingInteractor.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class LoadingInteractor: LoadingInteractorInput {
    
    private weak var output: LoadingInteractorOutput?
    
    func attach(_ output: LoadingInteractorOutput) {
        self.output = output
    }
    
    func checkLastVersion() {
        let version = RealmManager.fetchLastVersion()
        if version != nil {
            NetworkAPI.shared.fetchCurrentVersion() {[weak self] result in
                switch result {
                case .success(let lastVersion):
                    if version == lastVersion {
                        self?.output?.loadingDone()
                    }
                case.failure(let error):
                    print(error)
                }
                
            }
        }
        
    }
    
}
