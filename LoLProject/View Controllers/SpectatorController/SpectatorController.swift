//
//  SpectatorController.swift
//  LoLProject
//
//  Created by Антон on 14.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class SpectatorController: UIViewController {
    
    var spectatorDate: SpectatorDate?
    
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
    
    let array = [1,2,3,45,6]
    
    let coll1: CollectionViewDelegate = {
        return .init(data: [1,2,3])
    }()
    
    lazy var coll2: CollectionViewDelegate = {
        return .init(data: array)
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection1.dataSource = coll1
        collection1.delegate = coll1
        
        
        collection2.dataSource = coll2
        collection2.delegate = coll2
    }
    

// ARC
    
}

class CollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var champData = [Int]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        return cell
    }
    
    init(data: [Int]) {
        self.champData = data
        
        
//        [1,2,3,4,5,6,7].enumerated().forEach{
//            print($0.offset)
        }
    
    
}

// netfox
