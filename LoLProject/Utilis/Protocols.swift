//
//  Protocols.swift
//  LoLProject
//
//  Created by Антон on 06.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import Foundation

protocol LoginControllerDelegate: class {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?)
}

protocol BaseRequestProtocol  {
    associatedtype response: Decodable
    var urlRequest: URLRequest? { get }
}

protocol SpectatorDelegate: class {
    func dissmissAll()
}
