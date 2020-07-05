//
//  StatusTableHandler.swift
//  LoLProject
//
//  Created by Антон on 27.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class StatusTableHandler: NSObject, StatusTableHandlerProtocol {
   
    private weak var tableView: UITableView?
    var servers: [String] = []
    
    
    func attach(_ tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func setData(_ servers: [String]) {
        self.servers = servers
        tableView?.reloadData()
       }
    
}

extension StatusTableHandler: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "status", for: indexPath) as! StatusCell
        
        cell.serverName.text = servers[indexPath.row]
        cell.setData(server: servers[indexPath.row].serverNameToRegion())
        
        return cell
    }
    
}



