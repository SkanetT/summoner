//
//  StatusController.swift
//  LoLProject
//
//  Created by Антон on 10.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class StatusController: UIViewController {
    
    let tableView = UITableView()
    let servers = GlobalConstants.shared.servers
    
    var presenter: StatusPresenterInput?
    
    let refrechControll: UIRefreshControl = {
           let refrechControll = UIRefreshControl()
           refrechControll.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
           
           return refrechControll
       }()
    
    struct ServerStatusList {
        let name: String
        let status: String
    }
    
    var serverList: [ServerStatusList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.attach(self)
        setup()
        
    }
    
    
    @objc private func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
    }
    
    @objc
    func exit(){
        presenter?.didTapClose()
    }
    
    private func setup() {
        
        title = "Status"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exit))
        
        view.backgroundColor = .gray
        
        tableView.refreshControl = refrechControll
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .darkGray
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatusCell.self, forCellReuseIdentifier: "status")
        tableView.rowHeight = 60
    }
}

extension StatusController: UITableViewDelegate, UITableViewDataSource {
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

extension StatusController: StatusPresenterOutput {
    
}
