//
//  APINetwork.swift
//  LoLProject
//
//  Created by Антон on 04.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class NetworkAPI {
    
    func fetchCurrentChampionsList( completion: @escaping (Result<ChampionsData, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion.json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
         let task = session.dataTask(with: url) { data, response, rerror in
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
     
    func fetchCurrentVersion(completion: @escaping (Result<String, APIErrors>) -> () ) {
         let urlString = "https://ddragon.leagueoflegends.com/api/versions.json"
         guard let url = URL(string: urlString) else { return }
         let session = URLSession(configuration: .default)
         let task = session.dataTask(with: url) { data, response, rerror in
             if let data = data {
                 if let version = try? JSONDecoder().decode(VersionData.self, from: data), let currentVersion = version.first {
                     completion(.success(currentVersion))
                 } else {
                     completion(.failure(.parsing))
                 }
             }
         }
         task.resume()
     }
    
    func fetchFullInfoChampion(id: String, completion: @escaping (Result<SelectedChampion, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion/\(id).json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
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
                    
                    #warning("remove")
//                    
//                    if let championData = championsData.data["\(id)"] {
//                       
//                    }
                    
                    completion(.success(champion))
                } else {
                    completion(.failure(.network))
                }
        
            }
        }
        task.resume()
    }
    
    func fetchImageToChampionIcon(championId: String, completion: @escaping (UIImage?) -> ()) {
        var imageURL: URL?
        
       DispatchQueue(label: "com.lolproject", qos: .background).async {
            imageURL = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.9.1/img/champion/\(championId).png")
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
        
    }
    
    let globalConstans = GlobalConstants()
    func seachSummoner(name:String, completion: @escaping (Result<SummonerData, APIErrors>) -> () ) {
        let apiKey = globalConstans.apiKey

        let urlString = "https://euw1.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(name)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let myResponse = response as? HTTPURLResponse {
                if myResponse.statusCode == 404 {
                    completion (.failure(.summonerNotFound))
                }
                if myResponse.statusCode == 200 {
                    if let data = data {
                        if let summoner = try? JSONDecoder().decode(SummonerData.self, from: data)  {
                            completion(.success(summoner))
                        } else {
                            completion(.failure(.parsing))
                        }
                    }
                }
            }
            
        }
        task.resume()
    }
    
    func fetchMostPlayedChampions(summonerId: String, completion: @escaping (Result<MostPlayedChampionsData, APIErrors>) -> () ) {
        let apiKey = globalConstans.apiKey
        let urlString = "https://euw1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/\(summonerId)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                if let mostPlayedChampions = try? JSONDecoder().decode(MostPlayedChampionsData.self, from: data) {
                    completion(.success(mostPlayedChampions))
                } else {
                    completion(.failure(.parsing))
                }
            }
        }
        task.resume()
    }
    
    func fetchLeagues(summonerId: String, completion: @escaping (Result<LeagueData, APIErrors>) -> () ) {
        let apiKey = globalConstans.apiKey
        let urlString = "https://euw1.api.riotgames.com/lol/league/v4/entries/by-summoner/\(summonerId)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                if let leagueData = try? JSONDecoder().decode(LeagueData.self, from: data) {
                    completion(.success(leagueData))
                } else {
                    completion(.failure(.parsing))
                }
            }
        }
        task.resume()
    }
}
