//
//  HeaderForChampion.swift
//  LoLProject
//
//  Created by Антон on 31.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

class HeaderForChampion: XibBasedView {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var skins: [Skin] = []
    var id: String = ""
    var name: String = ""
    var title: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageControl.isHidden = true
        
        collectionView.register(UINib(nibName: "CellForHeaderForChampion", bundle: nil), forCellWithReuseIdentifier: "skins")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(id: String, skins: [Skin], name: String, title: String) {
        self.skins = skins
        self.id = id
        self.name = name
        self.title = title
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = skins.count
            
            self.pageControl.isHidden = false
        }
    }
    
}

extension HeaderForChampion: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return skins.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth, height: 225)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skins", for: indexPath) as! CellForHeaderForChampion
        
        if skins[indexPath.row].name != "default" {

            cell.skinName.text = skins[indexPath.row].name
        } else {
            cell.skinName.text = "\(name) \(title)"
        }
        
        
        cell.skinImage.downloadSD(type: .championWallpaper(id: id, index: String(skins[indexPath.row].num)))
        
        
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
   }
    
}
