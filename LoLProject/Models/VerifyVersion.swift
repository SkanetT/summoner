//
//  VerifyVersions.swift
//  LoLProject
//
//  Created by Антон on 26.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

typealias VersionData = [String]

class VerifyVersion {
    func fetchCurrentVersion(completion: @escaping (Result<String, APIErrors>) -> () ) {
        let urlString = "https://ddragon.leagueoflegends.com/api/versions.json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, rerror in
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
   

}






/* class NetworkAPI {
    static let shared = NetworkAPI()
    private init() {}
    private let versionService = VerifyVersion()
    
}
 */
