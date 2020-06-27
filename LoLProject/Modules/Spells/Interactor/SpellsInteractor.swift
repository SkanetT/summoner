//
//  SpellsInteractor.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import RealmSwift
import Foundation

class SpellsInteractor: SpellsInteractorInput {
    
    private weak var output: SpeellsnteractorOutput?

    
    func fetchSpellList() {
        output?.didReciveSpellList(spells: RealmManager.fetchSpellList())
    }
    
    
    func attach(_ output: SpeellsnteractorOutput) {
        self.output = output
    }
}

protocol SpellsInteractorInput: class {
    func attach(_ output: SpeellsnteractorOutput)
    func fetchSpellList()
}

protocol SpeellsnteractorOutput: class {
    func didReciveSpellList(spells: Results<SummonerSpell>)
}

