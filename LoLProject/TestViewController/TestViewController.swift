//
//  TestViewController.swift
//  LoLProject
//
//  Created by Антон on 28.04.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var collectionChampionsView: UICollectionView!
    
    var someString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = "Nya"
        
        collectionChampionsView.backgroundColor = .cyan
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
    }

    @objc
    private func dismissViewController() {
        navigationController?.dismiss(animated: true)
    }
    
    
    
    

}

//extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    
    

