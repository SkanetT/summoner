//
//  LoginController.swift
//  LoLProject
//
//  Created by Антон on 18.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var summonerNameTextField: UITextField!
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var serverChange: UIButton!
    
    var presenter: LoginPresenterInput?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func changeTap(_ sender: UIButton) {
        presenter?.serverChangeTap()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summonerNameTextField.delegate = self
        
        presenter?.attach(self)
        
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleColor
        title = "Login"
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        serverChange.clipsToBounds = true
        serverChange.layer.cornerRadius = 8
        
        summonerNameTextField.clipsToBounds = true
        summonerNameTextField.layer.cornerRadius = 8
        serverLabel.text = "Europe West"
        
    }
    
    @objc func handleMenu(){
        presenter?.sideMenuTap()
    }
    
}

extension LoginController: LoginPresenterOutput {
    
}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
        if let summonerName = summonerNameTextField.text, let region = serverLabel.text {
            presenter?.didInputName(summonerName, region)
            summonerNameTextField.text = ""
        } 
        
        
        return true
    }
}
