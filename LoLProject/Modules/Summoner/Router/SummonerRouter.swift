//
//  SummonerRouter.swift
//  LoLProject
//
//  Created by Антон on 07.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SummonerRouter: SummonerRouting {
    
    private weak var viewController: UIViewController?
    weak var delegate: LoginControllerDelegate?
    var saveTapHandler: (() -> ())?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func sideMenu() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func setSave(_ save: (() -> ())?) {
        self.saveTapHandler = save
    }
    
    func saveSummoner(save: String, found: String) {
        
        let ac = UIAlertController(title: "\(found) will save", message: "\(save) will delete", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) {[weak self]_ in
            self?.saveTapHandler?()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(ok)
        ac.addAction(cancel)
        viewController?.present(ac, animated: true)
        
    }
    
    func showError(_ error: APIErrors) {
        viewController?.showErrorMessage(error)
    }
    
    func spectatorPresent(_ data: SpectatorData) {
        DispatchQueue.main.async {
            let vc = SpectatorAssembler.createModule(data)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func rankPresent(_ data: RankData) {
        DispatchQueue.main.async {
            let leagueVC = LeagueAssembler.createModule(data)
            self.viewController?.navigationController?.pushViewController(leagueVC, animated: true)
        }
    }
}
