//
//  ViewController.swift
//  LoLProject
//
//  Created by Антон on 25.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class LoginController: SpinnerController {
        
    @IBOutlet weak var tfToPicker: NSLayoutConstraint!
    @IBOutlet weak var searchToPicker: NSLayoutConstraint!
    
    let realm = try! Realm()
    let foundSummoner = try! Realm().objects(FoundSummoner.self)
    
    var pickerAlpha = false
    
    @IBOutlet weak var verLabel: UILabel!
    @IBOutlet weak var summonerNameTF: UITextField!
    @IBOutlet weak var serverLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var serverButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    
    weak var delegate: LoginControllerDelegate?
    
    let servers = GlobalConstants.shared.servers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !foundSummoner.isEmpty {
            
            let summ = ContainerController()
            summ.isLogin = false
            
            summ.modalPresentationStyle = .fullScreen
            present(summ, animated: false)
            
        }
    }
    
    @objc func handleMenu(){
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        picker.delegate = self
        picker.dataSource = self
        
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.white.cgColor
        
        
        configureNavigationBar()
        
        DispatchQueue.main.async {
            self.serverLabel.text = self.servers.first
            if let lastVersion = RealmManager.fetchLastVersion() {
                self.verLabel.text = lastVersion
            }
        }
     //   updateCurrentVersion()
        
        
    }
    
    @IBAction func editingSummoner(_ sender: UITextField) {
        if sender.text!.count > 2 {
            self.searchButton.alpha = 1
            self.searchButton.isEnabled = true
        } else {
            self.searchButton.alpha = 0.5
            self.searchButton.isEnabled = false
            
        }
    }
    
    @IBAction func regionDidTap(_ sender: UIButton) {
        
        pickerAlpha = !pickerAlpha
        
        if pickerAlpha == true {
            UIView.animate(withDuration: 0.4) {
                self.picker.alpha = 1
                self.tfToPicker.constant = 0
                self.searchToPicker.constant = 0
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.picker.alpha = 0
                self.tfToPicker.constant = -71
                self.searchToPicker.constant = -137
                self.view.layoutIfNeeded()
                
            }
        }
    }
    
    @IBAction func searchDidTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.4) {
            self.picker.alpha = 0
            self.tfToPicker.constant = -71
            self.searchToPicker.constant = -137
            self.view.layoutIfNeeded()
            
        }
        showSpinner()
        
        guard  !summonerNameTF.text!.isEmpty else {return}
        
        guard let summonerName = summonerNameTF.text else { return }
        
        guard let region = serverLabel.text?.serverNameToRegion() else { return }
        
        let summonerRequest = SummonerRequest.init(summonerName: summonerName
            , server: region)
        
        NetworkAPI.shared.dataTask(request: summonerRequest) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let summonerData):
                DispatchQueue.main.async {
                    RealmManager.loginSummoner(summonerData: summonerData, region: region)

                    self.summonerNameTF.text? = ""
                    self.searchButton.alpha = 0.5
                    self.searchButton.isEnabled = false
                    
                    let container = ContainerController()
                    container.isLogin = false
        
                    container.modalPresentationStyle = .fullScreen
                    self.present(container, animated: true)
                }
                
                self.removeSpinner()
            case.failure(let error):
                
                self.removeSpinner()
                switch error {
                case .noData:
                    DispatchQueue.main.async {
                        let ac = UIAlertController(title: "\(self.summonerNameTF.text!) not found", message: "Check summoner name and region", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
                        ac.addAction(ok)
                        self.present(ac, animated: true)
                    }
                    
                case .statusCode(_), .network, .parsing, .unknown ,.noInternet:
                    self.showErrorMessage(error)
                }
            }
        }
    }
}

extension LoginController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        servers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return servers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DispatchQueue.main.async {
            self.serverLabel.text = self.servers[row]
        }
    }
}
