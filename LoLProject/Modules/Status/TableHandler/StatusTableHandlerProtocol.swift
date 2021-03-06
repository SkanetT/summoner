//
//  StatusTableHandlerProtocol.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

protocol StatusTableHandlerProtocol {
    func attach(_ tableView: UITableView)
    func setData(_ servers: [String])
}
