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
                var champion = SelectedChampion(name: "", title: "", passiveName: "", passiveImage: "", passiveDescription: "")
                
                for item in championsData.data {
                    if item.key == "\(id)" {
                        champion = SelectedChampion(name: item.value.name, title: item.value.title, passiveName: item.value.passive.name, passiveImage: item.value.passive.image.full, passiveDescription: item.value.passive.description)
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
