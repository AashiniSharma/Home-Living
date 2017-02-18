//
//  PopupImageVC.swift
//  Home&Living
//
//  Created by Appinventiv on 18/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class PopupImageVC: UIViewController {

    var image : UIColor!
    
    
    
    @IBOutlet weak var popUpImagesOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {

    popUpImagesOutlet.backgroundColor = image
      
    
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.33, animations: {
            
            UIView.setAnimationCurve(.easeInOut)
            
            
            UIView.setAnimationTransition(.curlDown, for: self.navigationController!.view!, cache: false) })
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
