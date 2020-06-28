//
//  StatusInteractor.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class StatusInteractor: StatusInteractorInput {
    
    
    
    weak var output: StatusInteractorOutput?
    
    func attach(_ output: StatusInteractorOutput) {
        self.output = output
        
    }
    func fetchServerList() {
        output?.didReciveServerList(servers: GlobalConstants.shared.servers)
    }
    
    
}
