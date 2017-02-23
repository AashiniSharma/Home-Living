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
    
    var effect : UIVisualEffect!
    //MARK: IB OUtlets
    @IBOutlet weak var popUpImagesOutlet: UIImageView!
    
    @IBOutlet weak var imageDetailsLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var extraView: UIView!
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //extraView.layer.cornerRadius = 5
        self.extraView.addSubview(visualEffectView)
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
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
    
    @IBAction func additionButton(_ sender: UIButton) {
        
        animateIn()
        
    }
    @IBAction func doneButtonInView(_ sender: UIButton) {
        
        animateOut()
        
    }
    
    //funtion of adding subview with blur effect
    func animateIn(){
        
        self.view.addSubview(extraView)
        extraView.center = self.view.center
        
        extraView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.extraView.alpha = 1
            self.extraView.transform = CGAffineTransform.identity

        }
    }
    
    //function of removing subview with blur effect
    func animateOut(){
        
        UIView.animate(withDuration: 0.3, animations: {

            //self.extraView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.visualEffectView.effect = nil
            self.extraView.removeFromSuperview()
            
        })
        
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
