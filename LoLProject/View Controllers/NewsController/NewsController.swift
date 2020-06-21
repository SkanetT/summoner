//
//  NewsController.swift
//  LoLProject
//
//  Created by Антон on 22.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import WebKit

class NewsController: UIViewController {
    
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        
        if let url = URL(string: "https://euw.leagueoflegends.com/en-gb/news/") {
            webView.load(URLRequest(url: url))
            
        }
        
        title = "News"
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitNews))
               

    }
    
    @objc func exitNews() {
        dismiss(animated: true, completion: nil)
    }
    
}
