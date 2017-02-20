//
//  genericFunctions.swift
//  Home&Living
//
//  Created by Appinventiv on 18/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    enum viewType{
    case UICollectionViewCell,UITableViewCell
    }
    
    static func getSuperView(givenObject : Any, designatedSuperView : viewType) -> Any{
        
        var cell = givenObject
        switch(designatedSuperView){
        case .UICollectionViewCell :
            
            while !(cell is UICollectionViewCell){
            
            cell = (cell as AnyObject).superview as Any
            }
            
        case .UITableViewCell :
            
            while !(cell is UITableViewCell){
                
                cell = (cell as AnyObject).superview as Any
            }
  
        }
    return cell
    
    }
}
