//
//  ContainerController.swift
//  LoLProject
//
//  Created by Антон on 06.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices

class ContainerController: UIViewController {
    
    var menuController: MenuController!
    var centerContoller: UIViewController!
    private var isExpanded = false
    
    var isLogin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogin {
            configureLoginController()
        } else {
            configureSummonerController()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    func configureLoginController() {
        let vc = LoginAssembler.createModule(delegate: self)
        
        centerContoller = UINavigationController(rootViewController: vc)
        
        centerContoller.view.frame = self.view.frame
        view.addSubview(centerContoller.view)
        addChild(centerContoller)
        centerContoller.didMove(toParent: self)
    }
    
    func configureSummonerController() {
         let vc = SummonerAssembler.createModule(delegate: self)
        
        centerContoller = UINavigationController(rootViewController: vc)
        
        centerContoller.view.frame = self.view.frame
        view.addSubview(centerContoller.view)
        addChild(centerContoller)
        centerContoller.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
            
            view.insertSubview(menuController.view, at: 0)
            
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
        
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.view.frame.size.height -= 80
                self.view.frame.origin.y += 40
                
                self.centerContoller.view.frame.origin.x  = self.centerContoller.view.frame.width - 80
                
            }, completion: nil)
            
        } else {
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.view.frame.size.height += 80
                self.view.frame.origin.y -= 40
                
                self.centerContoller.view.frame.origin.x  = 0
                
            }, completion: {[weak self] _ in
                guard let menuOption = menuOption else { return }
                
                self?.didSelectMenuOption(menuOption: menuOption)
                
            })
        }
        //  animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .champions:
            let vc = ChampionsListAssembler.createModule()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: true)
        case .spells:
            let vc = SpellsAssembler.createModule()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: true)
        case .serversStatus:
            let vc = StatusAssembler.createModule()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: true)
        case .news:
            if let url = URL(string: GlobalConstants.shared.newsUrlString) {
                let vc = SFSafariViewController(url: url)
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
              }
        }
    }
    
    @objc
    func logOut() {
        let ac = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .alert)
        let logOut = UIAlertAction(title: "Log Out", style: .default) {[weak self] _ in
            RealmManager.deleteSummoner()
            self?.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(logOut)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    @objc
    func swap() {
        guard let foundSummoner = RealmManager.fetchFoundSummoner(), let saveSummoner = RealmManager.fetchSaveSummoner() else { return }
        if foundSummoner.id == saveSummoner.id {
            dismiss(animated: true, completion: nil)
        } else {
            let request = SummonerRequest(summonerName: saveSummoner.name, server: saveSummoner.region)
            NetworkAPI.shared.dataTask(request: request) {[weak self] result in
                switch result {
                case .success( let summonerData):

                     DispatchQueue.main.async {
                        RealmManager.swapSummoners(summonerData)
                        self?.dismiss(animated: true, completion: nil)
                    }
                case.failure( let error):
                    self?.showErrorMessage(error)
                }
            }
        }
    }

    func animateStatusBar() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
}

extension ContainerController: LoginControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        menuController.logOut.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        menuController.swap.addTarget(self, action: #selector(swap), for: .touchUpInside)

        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}


