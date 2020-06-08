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
    static let que = DispatchQueue.init(label: "com.imageloader", qos: .utility, attributes: .concurrent)
    
    
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
    
    func seachSummoner(region:String, name:String, completion: @escaping (Result<SummonerData, APIErrors>) -> () ) {
        
        let urlString = "https://\(region).api.riotgames.com/lol/summoner/v4/summoners/by-name/\(name)?api_key=\(GlobalConstants.shared.apiKey)"
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
                    } else {
                        completion(.failure(.noData))
                    }
                }
            }
            
        }
        task.resume()
    }
    
    func fetchMostPlayedChampions(region: String,summonerId: String, completion: @escaping (Result<MostPlayedChampionsData, APIErrors>) -> () ) {
        let urlString = "https://\(region).api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/\(summonerId)?api_key=\(GlobalConstants.shared.apiKey)"
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
    
    func fetchLeagues(region: String ,summonerId: String, completion: @escaping (Result<LeagueData, APIErrors>) -> () ) {
        let urlString = "https://\(region).api.riotgames.com/lol/league/v4/entries/by-summoner/\(summonerId)?api_key=\(GlobalConstants.shared.apiKey)"
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
    
    func fetchMatchHistory(region: String,accountId: String, completion: @escaping (Result<MatchHistory, APIErrors>) -> () ) {
        let urlString = "https://\(region).api.riotgames.com/lol/match/v4/matchlists/by-account/\(accountId)?api_key=\(GlobalConstants.shared.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                if let matchHistory = try? JSONDecoder().decode(MatchHistory.self, from: data) {
                    completion(.success(matchHistory))
                } else {
                    completion(.failure(.parsing))
                }
            }
        }
        task.resume()
    }
    
    func fetchRankData (region: String, leagueId: String, completion: @escaping (Result<RankData, APIErrors>) -> () ) {
        let urlString = "https://\(region).api.riotgames.com/lol/league/v4/leagues/\(leagueId)?api_key=\(GlobalConstants.shared.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, rerror in
            if let data = data {
                if let rankData = try? JSONDecoder().decode(RankData.self, from: data) {
                    completion(.success(rankData))
                } else {
                    completion(.failure(.parsing))
                }
            }
        }
        task.resume()
    }
    
    func fetchFullInfoMatch(region: String,matchId: Int, completion: @escaping (Result<FullInfoMatch, APIErrors>) -> () ) {
        let urlString = "https://\(region).api.riotgames.com/lol/match/v4/matches/\(matchId)?api_key=\(GlobalConstants.shared.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        // Reachabiblity
        
        let task = session.dataTask(with: url) { data, response, rerror in
            guard let responseCode = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            switch responseCode.statusCode {
            case 200...300:
                if let data = data {
                    if let fullInfoMatch = try? JSONDecoder().decode(FullInfoMatch.self, from: data) {
                        completion(.success(fullInfoMatch))
                    } else {
                        
                        completion(.failure(.parsing))
                    }
                }
            default:
                completion(.failure(.statusCode(responseCode.statusCode)))
                
            }
            
        }
        task.resume()
    }
    
    
    
    func dataTask<Request: BaseRequestProtocol>(request: Request, completion: @escaping ((Result<Request.response,APIErrors>) -> ()) ) {
        if !Reachability.shared.isConnectedToNetwork().self {
            completion(.failure(.noInternet))
        }
        guard let req = request.urlRequest else {
            completion(.failure(.unknown))
            return
        }
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let data = data, let res = try? JSONDecoder().decode(Request.response.self, from: data) {
                completion(.success(res))
            } else {
                completion(.failure(.parsing))
            }
        }.resume()
    }



}
