//
//  ChampionsListPresenter.swift
//  LoLProject
//
//  Created by Антон on 05.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

class ChampionsListPresenter: ChampionsListPresenterInput {
    
    private weak var viewController: ChampionsListPresenterOutput?
    let interactor: ChampionsListInteractorInput
    let router: ChampionsListRouting
    
    
    init (_ interactor: ChampionsListInteractorInput, _ router: ChampionsListRouting) {
        self.router = router
        self.interactor = interactor
    }
    
    func attach(_ viewController: ChampionsListPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
        
    }
    
    func didTapClose() {
        router.dismiss()
    }
    
    func viewDidLoad() {
        interactor.fecthData()
        viewController?.setActionForCell() {[weak self] id in
            self?.interactor.fetchChampionInfo(id)
            self?.viewController?.championInfoLoadStart()
        }
    }
    
}

extension ChampionsListPresenter: ChampionsListInteractorOutput {
    func championInfoSuccess(_ champion: DataForFullInfo) {
        router.goToChampionInfo(champion)
        viewController?.championInfoLoadComlete()
    }
    
    func championInfoFailure(_ error: APIErrors) {
        viewController?.championInfoLoadComlete()

        print(error)
    }
    
    func didReceiveData(_ data: [ChampionListItem]) {
        let championList = data.sorted(by: {$0.name < $1.name})
        viewController?.didReceiveChampionList(championList)
    }
    
}
