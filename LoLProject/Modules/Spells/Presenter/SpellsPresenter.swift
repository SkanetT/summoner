//
//  SpellsPresenter.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

class SpellsPresenter: SpellsPresenterInput {
    
    private weak var viewController: SpellsPresenterOutput?
    private let router: SpellsRouting
    private let interactor: SpellsInteractorInput
    
    init(_ router: SpellsRouting, _ interactor: SpellsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func attach(_ viewController: SpellsPresenterOutput) {
        self.viewController = viewController
        interactor.attach(self)
    }
    
    func viewDidLoad() {
        interactor.fetchSpellList()
    }
    
    func didTapClose() {
        router.dismiss()
    }
    
}

extension SpellsPresenter: SpeellsInteractorOutput {
    func didReciveSpellList(spells: Results<SummonerSpell>) {
        viewController?.didReciveSpellList(spells.map{ .init(spellName: $0.name, spellDesc: $0.spellDescription, spellImgId: $0.id)}.sorted{$0.spellName < $1.spellName })
    }
    
}

