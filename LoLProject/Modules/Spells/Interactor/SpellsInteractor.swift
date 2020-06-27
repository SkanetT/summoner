//
//  SpellsInteractor.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//


import Foundation

class SpellsInteractor: SpellsInteractorInput {
    
    private weak var output: SpeellsInteractorOutput?

    
    func fetchSpellList() {
        output?.didReciveSpellList(spells: RealmManager.fetchSpellList())
    }
    
    
    func attach(_ output: SpeellsInteractorOutput) {
        self.output = output
    }
}




