//
//  PhotosControllerDataSource.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/8/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import UIKit
import Photos

class PhotosControllerDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let photoReuseIdentifier = "photoCell"
    let collectionView: UICollectionView
    let imageCachingManager = PHCachingImageManager()
    var thumbnailSize: CGSize = CGSize.zero
    
    var photoDict:[PHAssetCollection : PHFetchResult] = [PHAssetCollection : PHFetchResult]()
    var photos: PHFetchResult?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let size = flowLayout.itemSize
            let scale = UIScreen.mainScreen().scale
            self.thumbnailSize = CGSize(width: size.width * scale, height: size.height * scale)
            
        }
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    // MARK: - UICollectionView Delegate methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoReuseIdentifier,
            forIndexPath: indexPath) as! ThumbnailCollectionViewCell
        
        let currentTag = cell.tag + 1
        cell.tag = currentTag
        if let collection = self.photos?[indexPath.section] as? PHAssetCollection{
            let fetchResult = self.photoDict[collection]
            let asset = fetchResult![indexPath.item] as! PHAsset
            self.imageCachingManager.requestImageForAsset(asset, targetSize: self.thumbnailSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
                
                //update the image if the tag is current
                if cell.tag == currentTag{
                    cell.photoImageView.image = image
                }
            }
        }
        else{
            let asset = self.photos![indexPath.item] as! PHAsset
            self.imageCachingManager.requestImageForAsset(asset, targetSize: self.thumbnailSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
                
                //update the image if the tag is current
                if cell.tag == currentTag{
                    cell.photoImageView.image = image
                }
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.photos != nil {
            if let collection = self.photos?[section] as? PHAssetCollection{
                if let fetchRequest = self.photoDict[collection]{
                    return fetchRequest.count
                }
                else{
                    let fetchRequest = PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
                    photoDict[collection] = fetchRequest
                    return fetchRequest.count
                }
            }
            else{
               self.photos!.count
            }
        }
        
        return 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if self.photos != nil{
            if let _ = self.photos?.firstObject as? PHAssetCollection{
                return self.photos!.count
            }
            
            return self.photos!.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! HeaderCollectionView
            
            if self.photos != nil {
                if let _ = self.photos?[indexPath.section] as? PHAssetCollection{
                    header.titleLabel.text = self.photos![indexPath.section].localizedTitle
                    return header
                }
            }
            
            header.titleLabel.text = ""
            
            return header
        }
        else{
            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath) as! FooterCollectionView
            
            if self.photos != nil {
                if let collection = self.photos?[indexPath.section] as? PHAssetCollection{
                    if let fetchRequest = self.photoDict[collection]{
                        footer.titleLabel.text = "count: \(fetchRequest.count)"
                        return footer
                    }
                    else{
                        let fetchRequest = PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
                        photoDict[collection] = fetchRequest
                        footer.titleLabel.text = "count: \(fetchRequest.count)"
                        return footer
                    }
                }
                else{
                    footer.titleLabel.text = "count: \(self.photos!.count)"
                    return footer
                }
            }

            footer.titleLabel.text = ""
            return footer
        }
    }
    
}
