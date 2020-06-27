//
//  SpeellsnteractorOutput.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation
import RealmSwift

protocol SpeellsInteractorOutput: class {
    func didReciveSpellList(spells: Results<SummonerSpell>)
}
