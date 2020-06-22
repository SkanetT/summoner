//
//  ContainerController.swift
//  LoLProject
//
//  Created by Антон on 06.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit
import RealmSwift

class ContainerController: UIViewController {
    
    var menuController: MenuController!
    var centerContoller: UIViewController!
    var isExpanded = false
    
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
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "login") as! LoginController
        vc.delegate = self
        centerContoller = UINavigationController(rootViewController: vc)
        
        
        view.addSubview(centerContoller.view)
        addChild(centerContoller)
        centerContoller.didMove(toParent: self)
        
    }
    
    func configureSummonerController() {
        let vc = SummonerViewController()
        vc.delegate = self
        centerContoller = UINavigationController(rootViewController: vc)
        
        
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
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "championList2")
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
            
            
        case .spells:
            let vc = SpellsViewController()
            let nc = UINavigationController(rootViewController: vc)
            
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: true)
            
        case .serversStatus:
            let vc = StatusController()
            let nc = UINavigationController(rootViewController: vc)
            
            nc.modalPresentationStyle = .fullScreen
            
            present(nc, animated: true)
            
        case .news:
            let vc = NewsController()
            let nc = UINavigationController(rootViewController: vc)
            
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: true)
            
        }
        
    }
    
    @objc
    func logOff() {
        let ac = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .alert)
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) {[weak self] _ in
            
            let realm = try! Realm()
            let summoner = try! Realm().objects(FoundSummoner.self)
            try! realm.write {
                realm.delete(summoner)
            }
            
            self?.dismiss(animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(logOut)
        ac.addAction(cancel)
        present(ac, animated: true)
        
        
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
        menuController.logOff.addTarget(self, action: #selector(logOff), for: .touchUpInside)

        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}


