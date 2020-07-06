//
//  ChampionInfoPresenter.swift
//  LoLProject
//
//  Created by Антон on 06.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class ChampionInfoPresenter: ChampionInfoPresenterInput {
    
    private weak var viewController: ChampionInfoPresenterOutput?
    let interactor: ChampionInfoInteractorInput
    let router: ChampionInfoRouting
    func attach(_ viewController: ChampionInfoPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    
    init (_ interactor: ChampionInfoInteractorInput, _ router: ChampionInfoRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fecthData()
    }
    
    func didTapClose() {
        router.dismiss()
    }
    
}

extension ChampionInfoPresenter: ChampionInfoInteractorOutput {
    func didReceiveDataAndId(data: SelectedChampion, id: String) {
        viewController?.dataHasCome(data: data, id: id)
        viewController?.didReceiveTitle(data.name)
    }
    
    
}
