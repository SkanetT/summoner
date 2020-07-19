//
//  TestController1.swift
//  LoLProject
//
//  Created by Антон on 19.07.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class PickerController: UIViewController {
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        return bdView
    } ()
    
    let menuView = UIView()
    let menuHeight = (UIScreen.main.bounds.height / 2) - 10
    let selectButton = UIButton()
    let picker = UIPickerView()
    var isPresenting = false
    
    let servers = GlobalConstants.shared.servers
    var serverHandler: ((String) -> ())?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(menuView)
        
        
        menuView.clipsToBounds = true
        menuView.layer.cornerRadius = 8
        menuView.layer.borderColor = UIColor.white.cgColor
        menuView.layer.borderWidth = 1
        
        picker.delegate = self
        picker.dataSource = self
        
        menuView.backgroundColor = .lightGray
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.backgroundColor = .black
        selectButton.setTitle("Select", for: .normal)
        selectButton.clipsToBounds = true
        selectButton.layer.cornerRadius = 8
        selectButton.layer.borderColor = UIColor.white.cgColor
        selectButton.layer.borderWidth = 1
        
        menuView.addSubview(selectButton)
        selectButton.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -16).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: menuHeight / 8).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 8).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: -8).isActive = true
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(picker)
        
        picker.topAnchor.constraint(equalTo: menuView.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: selectButton.topAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: menuView.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: menuView.trailingAnchor).isActive = true
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        backdropView.addGestureRecognizer(tapGesture1)
        selectButton.addGestureRecognizer(tapGesture2)
        
        if let first = servers.first {
            serverHandler?(first)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func setServer(_ server: ((String) -> ())? ) {
        self.serverHandler = server
    }
}

extension PickerController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)
        guard let toVC = toViewController else { return }
        isPresenting.toggle()
        
        if isPresenting {
            containerView.addSubview(toVC.view)
            
            menuView.frame.origin.y += menuHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backdropView.alpha = 1
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
}

extension PickerController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        serverHandler?(servers[row])
    }
}
