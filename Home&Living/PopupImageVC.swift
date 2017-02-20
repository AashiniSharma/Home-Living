//
//  PopupImageVC.swift
//  Home&Living
//
//  Created by Appinventiv on 18/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class PopupImageVC: UIViewController {
    
    
    //MARK : properties
    var image : UIColor!
    //MARK: IB OUtlets
    @IBOutlet weak var popUpImagesOutlet: UIImageView!
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillLayoutSubviews() {

    popUpImagesOutlet.backgroundColor = image
   
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.33, animations: {
        UIView.setAnimationTransition(.curlDown, for: self.navigationController!.view!, cache: false) })
        
    }

}
