//
//  MenuDataSource.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/8/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import UIKit
import Photos

protocol MenuSelectionDelegate{
    func selectionChanged(menuIndex: Int)
}

class MenuDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    let menuReuseIdentifier = "menuCell"
    var menus = ["Last Month","Last 3 Months", "Albums"]
    var selectionDelegate: MenuSelectionDelegate? = nil
    
    let collectionView: UICollectionView
    var selectedIndexPath: NSIndexPath {
        didSet{
            selectionDelegate?.selectionChanged(selectedIndexPath.item)
        }
    }
    
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        self.selectedIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        super.init()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.registerNib(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: menuReuseIdentifier)
        
        let menuFlowLayout = UICollectionViewFlowLayout()
        menuFlowLayout.itemSize = CGSize(width: 125, height: 50)
        menuFlowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        menuFlowLayout.minimumInteritemSpacing = 0.0
        menuFlowLayout.minimumLineSpacing = 0.0
        self.collectionView.collectionViewLayout = menuFlowLayout
    }
    
    // MARK: - UICollectionView Delegate methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(menuReuseIdentifier,
            forIndexPath: indexPath) as! MenuCollectionViewCell
        
        cell.menuTitle.text = self.menus[indexPath.row]
        cell.selectedBar.hidden = selectedIndexPath == indexPath ? false : true
        cell.menuTitle.textColor = self.collectionView.tintColor
        cell.selectedBar.backgroundColor = self.collectionView.tintColor
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int)->UIEdgeInsets{
            
        return UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let prevSelectedPath  = selectedIndexPath
        selectedIndexPath = indexPath
        collectionView.reloadItemsAtIndexPaths([prevSelectedPath, indexPath])
    }
}
