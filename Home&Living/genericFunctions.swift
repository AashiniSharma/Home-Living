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
    
    
    var tableViewCell : UITableViewCell?{
        
        var cell = self
        while !(cell is UITableViewCell){
            
            guard let s = cell.superview else { return nil }
            cell = s
            
       }
        return cell as? UITableViewCell
    }
    
    var collectionViewCell : UICollectionViewCell?{
        
        var cell = self
        while !(cell is UICollectionViewCell){
            
            guard let s = cell.superview else{ return nil }
            cell = s
            
        }
        return cell as? UICollectionViewCell
    }

}
