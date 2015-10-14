//
//  PhotoViewController.swift
//  PhotoViewer
//
//  Created by Keith Elliott on 10/9/15.
//  Copyright © 2015 GittieLabs. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoAsset: UIImageView!
    var asset: PHAsset?
    var assetCollection: PHAssetCollection?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.hidesBarsOnTap = true
        self.navigationController!.hidesBarsOnSwipe = true
        updateImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.hidesBarsOnSwipe = false
        self.navigationController!.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateImage(){
        let scale = UIScreen.mainScreen().scale
        let size = CGSize(width: self.photoAsset.bounds.width * scale, height: self.photoAsset.bounds.height * scale)
        let options = PHImageRequestOptions()
        options.networkAccessAllowed = true
        PHImageManager.defaultManager().requestImageForAsset(self.asset!, targetSize: size, contentMode: PHImageContentMode.AspectFill, options: options) { (image, info) -> Void in
            if (image != nil){
                self.photoAsset.image = image
            }
        }
    }

}
