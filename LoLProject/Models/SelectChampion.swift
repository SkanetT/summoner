//
//  SelectChampion.swift
//  LoLProject
//
//  Created by Антон on 01.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

struct SelectedChampion {
    let name, title: String
    let passiveName, passiveImage, passiveDescription: String
    let qName, qImage, qDescription, qTooltip: String
    let wName, wImage, wDescription: String
    let eName, eImage, eDescription: String
    let rName, rImage, rDescription: String
    
    init(item: Dictionary<String, Info>.Element) {
        name = item.value.name
        title = item.value.title
        passiveName = item.value.passive.name
        passiveImage = item.value.passive.image.full
        passiveDescription = item.value.passive.description
        qName = item.value.spells[0].name
        qImage = item.value.spells[0].image.full
        qDescription = item.value.spells[0].description
        qTooltip = item.value.spells[0].tooltip
        wName = item.value.spells[1].name
        wImage = item.value.spells[1].image.full
        wDescription = item.value.spells[1].description
        eName = item.value.spells[2].name
        eImage = item.value.spells[2].image.full
        eDescription = item.value.spells[2].description
        rName = item.value.spells[3].name
        rImage = item.value.spells[3].image.full
        rDescription = item.value.spells[3].description 
    }
}

