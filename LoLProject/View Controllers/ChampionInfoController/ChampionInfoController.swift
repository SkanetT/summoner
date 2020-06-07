//
//  ViewController.swift
//  LoLProject
//
//  Created by Антон on 29.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ChampionInfoController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let footer = FooterForChampion()
    let header = HeaderForChampion()
    
    var championData: SelectedChampion?
    
//    var count = 0
    
    
    
    var id = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func exitChampions() {
        dismiss(animated: true, completion: nil)
        
    }
       
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.allowsSelection = false
        
        
////        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(back))
//        navigationItem.backBarButtonItem = .init(title: "Back", style: .plain, target: self, action: #selector(back))
        
//        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(exitChampions))
        
        
        title = championData?.name
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
//            self.tableView.reloadData()
//        })
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "SkillCell", bundle: nil), forCellReuseIdentifier: "skill")
        
        
    }
    
    @objc
    private func dismissViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension ChampionInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skill", for: indexPath) as! SpellsCell
        guard let championData = championData else { return cell }
        
                switch indexPath.row {

                case 0:
                    cell.setData(isPassive: true, image: championData.passiveImage, key: "Passive", name: championData.passiveName, description: championData.passiveDescription)

                case 1:
                    cell.setData(isPassive: false, image: championData.qImage, key: "[Q]", name: championData.qName, description: championData.qDescription)
                case 2:
                    cell.setData(isPassive: false, image: championData.wImage, key: "[W]", name: championData.wName, description: championData.wDescription)
                case 3:
                    cell.setData(isPassive: false, image: championData.eImage, key: "[E]", name: championData.eName, description: championData.eDescription)
                case 4:
                    cell.setData(isPassive: false, image: championData.rImage, key: "[R]", name: championData.rName, description: championData.rDescription)
                default:

                    break
                }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        NetworkAPI.shared.fetchFullInfoChampion(id: id) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let champion):
                self.header.setData(id: self.id, skins: champion.skins, name: champion.name, title: champion.title)
                
            case .failure:
                print("Errort")
            }
        }
        
        //    header.setData(id: id)
        
        return header
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        NetworkAPI.shared.fetchFullInfoChampion(id: id) {[weak self] result in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    self?.footer.setData(lore: champion.lore)
                }
                
            case .failure:
                print("Errort")
            }
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }

    
}



