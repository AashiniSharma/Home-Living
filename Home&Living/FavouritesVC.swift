//
//  FavouritesVC.swift
//  Home&Living
//
//  Created by Appinventiv on 01/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage

class FavouritesVC: UIViewController {

    var favImagesArray = [ImageInfo]()
    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "VarietiesofHome_Living", bundle: nil)
        self.favouriteCollectionView.register(nib, forCellWithReuseIdentifier: "VarietiesofHome_LivingID")
        self.favouriteCollectionView.dataSource = self
        self.favouriteCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavouritesVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return favImagesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VarietiesofHome_LivingID", for: indexPath) as? VarietiesofHome_Living else { fatalError("Cell not found") }
        let url = URL(string: favImagesArray[indexPath.row].previewURL)
        cell.varietiesImages.af_setImage(withURL: url!)
        cell.varietyLabel.text = favImagesArray[indexPath.row].id
        cell.favouritesButtonOutlet.isHidden = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let popUpImagePage = self.storyboard?.instantiateViewController(withIdentifier: "PopupImageVCID") as? PopupImageVC else { return }
        
        let data = favImagesArray[indexPath.row]
        popUpImagePage.imageUrl = URL(string: data.webformatURL)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.navigationController!.pushViewController(popUpImagePage, animated: false)
            
        })
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 100, height: 100)
        
    }
}
