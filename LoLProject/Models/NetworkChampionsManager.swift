//
//  NetworkChampionManager.swift
//  LoLProject
//
//  Created by Антон on 25.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation





class NetworkChampionsManager {
    
    
    func fetchCurrentChampions( completion: @escaping (Result<ChampionsData, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.8.1/data/en_US/champion.json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, rerror in
            if let data = data {
                if let championsData = try? JSONDecoder().decode(ChampionsData.self, from: data) {
                    completion(.success(championsData))
                } else {
                    completion(.failure(.network))
                }
        
            }
        }
        task.resume()
    }
    
    

}



