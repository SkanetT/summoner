//
//  FullInfoChampion.swift
//  LoLProject
//
//  Created by Антон on 01.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

func getInfo(id: String, completion: @escaping (Result<SelectedChampion, APIErrors>) -> () ) {
    let urlString = "https://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion/\(id).json"
    guard let url = URL(string: urlString) else { return }
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, responce, rerror in
        if let data = data {
            if let championsData = try? JSONDecoder().decode(SelectedChampionsData.self, from: data) {
                var champion = SelectedChampion(name: "", title: "", passiveName: "", passiveImage: "", passiveDescription: "", qName: "", qImage: "", qDescription: "", qTooltip: "",
                                                wName: "", wImage: "", wDescription: "", eName: "", eImage: "", eDescription: "", rName: "", rImage: "", rDescription: "")
                
                for item in championsData.data {
                    if item.key == "\(id)" {
                        champion = SelectedChampion(name: item.value.name, title: item.value.title, passiveName: item.value.passive.name, passiveImage: item.value.passive.image.full, passiveDescription: item.value.passive.description,
                                                    qName: item.value.spells[0].name, qImage: item.value.spells[0].image.full, qDescription: item.value.spells[0].description, qTooltip: item.value.spells[0].tooltip,
                            wName: item.value.spells[1].name, wImage: item.value.spells[1].image.full, wDescription: item.value.spells[1].description, eName: item.value.spells[2].name, eImage: item.value.spells[2].image.full, eDescription: item.value.spells[2].description, rName: item.value.spells[3].name, rImage: item.value.spells[3].image.full, rDescription: item.value.spells[3].description )
                    }
                }
                
                
                completion(.success(champion))
            } else {
                completion(.failure(.network))
            }
    
        }
    }
    task.resume()
}
