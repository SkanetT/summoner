//
//  SummonerPresenter.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class SummonerPresenter: SummonerPresenterInput {
    
    private weak var viewController: SummonerPresenterOutput?
    let interactor: SummonerInteractorInput

    init (_ interactor: SummonerInteractorInput) {
        self.interactor = interactor
    }
    
    func attach(_ viewController: SummonerPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    
    func viewDidLoad() {
        interactor.fetchMostPlayedChampions()
    }
}

extension SummonerPresenter: SummonerInteractorOutput {
    func successMostPlayedChampions(_ data: MostPlayedChampionsData) {
        if data.count >= 3 {
            viewController?.didReceiveMostPlayedView(data)
        } else {
            viewController?.didReceiveNoMostPlayedView()
        }
    }
    
    func failureMostPlayedChampions(_ error: APIErrors) {
        print(error)
    }
    
    
}
