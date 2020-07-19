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
    @IBOutlet weak var versionLabel: UILabel!
    
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
        serverChange.layer.borderColor = UIColor.white.cgColor
        serverChange.layer.borderWidth = 1
        
        summonerNameTextField.clipsToBounds = true
        summonerNameTextField.layer.cornerRadius = 8
        
        if let firstServer = GlobalConstants.shared.servers.first {
            serverLabel.text = firstServer
        }
        if let lastVersion = RealmManager.fetchLastVersion() {
            versionLabel.text = "Version: \(lastVersion)"
        }
    }
    
    @objc func handleMenu(){
        presenter?.sideMenuTap()
    }
}

extension LoginController: LoginPresenterOutput {
    func newServerReceive(_ server: String) {
        DispatchQueue.main.async {
            self.serverLabel.text = server
        }
    }
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
