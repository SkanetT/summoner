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
    var tableHandler: StatusTableHandlerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.attach(self)
        presenter?.viewDidLoad()
        tableHandler?.attach(tableView)
        setupUI()
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exit))
        tableView.register(StatusCell.self, forCellReuseIdentifier: "status")

        
    }
    
    @objc
    func exit(){
        presenter?.didTapClose()
    }
    
    private func setupUI() {
        
        title = "Status"
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = titleColor        
       
        
        view.backgroundColor = .gray
                
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .darkGray
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.rowHeight = 60
    }
}


extension StatusController: StatusPresenterOutput {
    func didReciveServerList(servers: [String]) {
        tableHandler?.setData(servers)
    }
}
