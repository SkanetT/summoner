//
//  APINetwork.swift
//  LoLProject
//
//  Created by Антон on 04.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift


class NetworkAPI {
    
    static let shared = NetworkAPI()
    
    func dataTask<Request: BaseRequestProtocol> (request: Request, completion: @escaping ((Result<Request.response,APIErrors>) -> ()) ) {
        guard Reachability.shared.isConnectedToNetwork() else {
            completion(.failure(.noInternet))
            return
        }
        guard let req = request.urlRequest else {
            completion(.failure(.unknown))
            return
        }
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let responseCode = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            
            switch responseCode.statusCode {
            case 200...300:
                if let data = data, let res = try? JSONDecoder().decode(Request.response.self, from: data) {
                    completion(.success(res))
                } else {
                    completion(.failure(.parsing))
                }
            case 404:
                completion(.failure(.noData))
            default:
                completion(.failure(.statusCode(responseCode.statusCode)))
            }
            
        }.resume()
    }
    
    func fetchCurrentChampionsList(completion: @escaping (Result<ChampionsData, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.11.1/data/en_US/champion.json"
        
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
    
    func fetchCurrentItemsList( completion: @escaping (Result<ItemsData, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.11.1/data/en_US/item.json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                if let itemsData = try? JSONDecoder().decode(ItemsData.self, from: data) {
                    completion(.success(itemsData))
                } else {
                    completion(.failure(.network))
                }
            }
        }
        task.resume()
    }
    
    func fetchCurrentSpellsList( completion: @escaping (Result<SummonerSpellsData, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.11.1/data/en_US/summoner.json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                if let summonerSpellsData = try? JSONDecoder().decode(SummonerSpellsData.self, from: data) {
                    completion(.success(summonerSpellsData))
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
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.11.1/data/en_US/champion/\(id).json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                
                if let championsData = try? JSONDecoder().decode(SelectedChampionsData.self, from: data) {
                    
                    if let champion = championsData.data.first(where: { $0.key == "\(id)" }) {
                        let selectedChampion = SelectedChampion.init(item: champion)
                        completion(.success(selectedChampion))
                    }
                    
                } else {
                    print("🌐")
                    completion(.failure(.network))
                }
                
            }
        }
        task.resume()
    }
}
