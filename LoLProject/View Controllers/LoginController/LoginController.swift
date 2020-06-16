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
    
    // @IBOutlet var tfToTop: NSLayoutConstraint!
    
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
    
    
    var delegate: LoginControllerDelegate?
    
    
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
            present(summ, animated: true)
           
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //    navigationController?.setNavigationBarHidden(false, animated: true)
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
        }
                updateCurrentVersion()
        
        
        
        let realm = try! Realm()
        let version = try! Realm().objects(Version.self)
        if let lastVersion = version.first?.lastVesion {
            NetworkAPI.shared.fetchCurrentVersion() {[weak self] result in
                switch result {
                    
                case .success(let version):
                    if version != lastVersion {
                        DispatchQueue.main.async {
                            try! realm.write {
                                realm.deleteAll()
                            }
                            //diente
                            self?.getVersionRealm() // disleave
                            //disenter
                            self?.getChampionsListRealm() // dislo
                            self?.getItemsListRealm()
                            self?.getSpellsListRealm()
                            self?.updateCurrentVersion()

                        }
                        
                    }
                case.failure:
                    print("error")
                }
            }
        } else {
            DispatchQueue.main.async {
                self.getVersionRealm()
                self.getChampionsListRealm()
                self.getItemsListRealm()
                self.getSpellsListRealm()
                self.updateCurrentVersion()
                
                
            }
            updateCurrentVersion()
            
        }
        
        
        
        
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
            
            //  picker.isHidden.toggle()
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
            case .success(let summoner):
                let realm = try! Realm()
                let foundSummoner = FoundSummoner()
                foundSummoner.name = summoner.name
                foundSummoner.id = summoner.id
                foundSummoner.accountId = summoner.accountId
                foundSummoner.puuid = summoner.puuid
                foundSummoner.profileIconId = summoner.profileIconId
                foundSummoner.summonerLevel = summoner.summonerLevel
                foundSummoner.region = region
                
                
                try! realm.write {
                    realm.add(foundSummoner)
                    
                    
                }
                DispatchQueue.main.async {
                    self.summonerNameTF.text? = ""
                    self.searchButton.alpha = 0.5
                    self.searchButton.isEnabled = false
                    
                    let summ = ContainerController()
                    summ.isLogin = false
                    
                    
                    summ.modalPresentationStyle = .fullScreen
                    self.present(summ, animated: true)
                    
                    //   self.navigationController?.pushViewController(summ, animated: true)
                    //                    let summonerVC = SummonerViewController()
                    //                    self.navigationController?.pushViewController(summonerVC, animated: true)
                }
                
                self.removeSpinner()
            case.failure(let error):
                guard case .noData = error else { return }
                self.removeSpinner()

                DispatchQueue.main.async {
                    let ac = UIAlertController(title: "\(self.summonerNameTF.text!) not found", message: "Check summoner name and region", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    ac.addAction(ok)
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    private func updateCurrentVersion() {
        
        let versions = try! Realm().objects(Version.self)
        if let versin = versions.first {
            DispatchQueue.main.async {
                self.verLabel.text = versin.lastVesion
            }
        }
    }
    
    private func getChampionsListRealm(){
        NetworkAPI.shared.fetchCurrentChampionsList() { result in
            switch result {
            case .success(let championData):
                let realm = try! Realm()
                for item in championData.data {
                    let champion = Champion()
                    champion.id = item.key
                    champion.name = item.value.name
                    champion.key = item.value.key
                    try! realm.write {
                        realm.add(champion)
                    }
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func getItemsListRealm(){
        NetworkAPI.shared.fetchCurrentItemsList() { result in
            switch result {
            case .success(let itemData):
                let realm = try! Realm()
                for item in itemData.data {
                    let lolItem = Item()
                    lolItem.id = item.key
                    lolItem.name = item.value.name
                    lolItem.colloq = item.value.colloq
                    lolItem.itemDescription = item.value.description
                    lolItem.plaintext = item.value.plaintext
                    try! realm.write {
                        realm.add(lolItem)
                    }
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func getSpellsListRealm() {
        NetworkAPI.shared.fetchCurrentSpellsList() { result in
            switch result {
            case.success(let spellsData):
                let realm = try! Realm()
                for item in spellsData.data {
                    let spell = SummonerSpell()
                    
                    if item.key != "SummonerSnowURFSnowball_Mark"
                    {
                        spell.id = item.key
                        spell.name = item.value.name
                        spell.key = item.value.key
                        spell.spellDescription = item.value.description
                        spell.tooltip = item.value.tooltip
                        try! realm.write {
                            realm.add(spell)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private  func getVersionRealm() {
        NetworkAPI.shared.fetchCurrentVersion() { result in
            switch result {
            case .success(let lastVersion):
                let realm = try! Realm()
                let version = Version()
                version.lastVesion = lastVersion
                try! realm.write {
                    realm.add(version)
                }
            case .failure(let error):
                print(error)
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
