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
    var imageUrl : URL!
    //MARK: IB OUtlets
    @IBOutlet weak var popUpImagesOutlet: UIImageView!
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding panGesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewDidDragged(panGesture:)))
        popUpImagesOutlet.addGestureRecognizer(panGesture)
   
    }
    
    //setting the background color of this view with the image of main view cells
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        popUpImagesOutlet.animationDuration = 2.0
        popUpImagesOutlet.af_setImage(withURL: imageUrl)
        
       
    }
    
    //function of panGesture
    func viewDidDragged(panGesture : UIPanGestureRecognizer){
        
        
        let newPoint = panGesture.translation(in: self.popUpImagesOutlet)
        print(newPoint)
        
        switch panGesture.state {
            
        case .began :
            print("began")
            
        case .changed :
            popUpImagesOutlet.transform = CGAffineTransform(translationX: newPoint.x, y: newPoint.y)
            
        case .ended :
            print("ended")
            
        default:
            print("hi")
        }
        
        
    }


}
