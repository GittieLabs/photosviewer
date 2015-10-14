//
//  MainDataSource.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/8/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import UIKit
import Photos

class MainDataSource: NSObject, MenuSelectionDelegate {
    var menusDataSource: MenuDataSource
    var photosDataSource: PhotosControllerDataSource
    let menuCollectionView: UICollectionView
    let photosCollectionView: UICollectionView
    
    var collectionFetchResults:[PHFetchResult]!
    
    init(menuCollectionView: UICollectionView, photosCollectionView: UICollectionView){
        self.menuCollectionView = menuCollectionView
        self.photosCollectionView = photosCollectionView
        self.menusDataSource = MenuDataSource(collectionView: self.menuCollectionView)
        self.photosDataSource = PhotosControllerDataSource(collectionView: self.photosCollectionView)
        
        super.init()   // needs to be called after local vars are initialized
        
        self.menusDataSource.selectionDelegate = self
        fetchPhotoCollections()
        selectionChanged(0)  // sets the first menu item as selected
    }
    
    func fetchPhotoCollections(){
        let today = NSDate()
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        options.predicate = NSPredicate(format: "(startDate >= %@) AND (endDate <= %@)", today.dateByAddingMonths(-1), today)
        let lastMonth = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: options)
        
        options.predicate = NSPredicate(format: "(startDate >= %@) AND (endDate <= %@)", today.dateByAddingMonths(-3), today)
        let past3Months = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options: options)
        
        let album = PHAssetCollection.fetchAssetCollectionsWithType(.Moment, subtype: .Any, options:nil)
        self.collectionFetchResults = [lastMonth, past3Months, album]
        
        self.photosDataSource.photos = self.collectionFetchResults[0]
    }
    
    // MARK: - MenuSelectionDelegate methods
    func selectionChanged(menuIndex: Int) {
        let fetchResult = self.collectionFetchResults[menuIndex]
        self.photosDataSource.photos = fetchResult
    }
}