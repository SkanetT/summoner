//
//  LoadingController.swift
//  LoLProject
//
//  Created by Антон on 15.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter: LoadingPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = false
        indicator.startAnimating()
        
        presenter?.attach(self)
        presenter?.viewDidLoad()
    }
}

extension LoadingController: LoadingPresenterOutput {
    
}
