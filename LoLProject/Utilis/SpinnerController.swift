//
//  SpinnerController.swift
//  LoLProject
//
//  Created by Антон on 16.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpinnerController: UIViewController {
    
    let aView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.backgroundColor = .darkGray
        view.addSubview(aView)

        aView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        aView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        aView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        aView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        aView.isHidden = true
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        aView.addSubview(ai)

        ai.isHidden = false
        ai.color = .white
        ai.centerYAnchor.constraint(equalTo: aView.centerYAnchor).isActive = true
        ai.centerXAnchor.constraint(equalTo: aView.centerXAnchor).isActive = true

        
        ai.startAnimating()
        
    }
    
    
    func showSpinner() {
        
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.aView)

            self.aView.isHidden = false
            
        }
        
        
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.aView.isHidden = true

        }
    }
    
}

extension UIViewController {
    func showErrorMessage(_ error: APIErrors) {
        DispatchQueue.main.async {
            let ac = UIAlertController()
            ac.addAction(.init(title: error.desc, style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
}
