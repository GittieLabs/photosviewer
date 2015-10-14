//
//  ThumbnailViewController.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/7/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import UIKit
import Photos

class ThumbnailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var mainDataSource:MainDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainDataSource = MainDataSource(menuCollectionView: self.menuCollectionView, photosCollectionView: self.thumbnailCollectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhoto"{
            if let indexPath = self.thumbnailCollectionView.indexPathForCell(sender as! UICollectionViewCell){
                guard let destVC = segue.destinationViewController as? PhotoViewController else { return }
                if let collection = self.mainDataSource.photosDataSource.photos?[indexPath.section] as? PHAssetCollection{
                    let fetchResult = self.mainDataSource.photosDataSource.photoDict[collection]
                    let asset = fetchResult![indexPath.item] as! PHAsset
                destVC.asset = asset
                }
                
            }
        }
    }
}