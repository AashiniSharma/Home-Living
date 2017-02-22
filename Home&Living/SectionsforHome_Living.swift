//
//  SectionsforHome_Living.swift
//  Home&Living
//
//  Created by Appinventiv on 18/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class SectionsforHome_Living: UITableViewCell {
    
    
    var tableIndexpath = IndexPath()
    
   //MARK : IB Outlets
    @IBOutlet weak var home_LivingCollectionView: UICollectionView!
    @IBOutlet weak var brandsLabel: UILabel!
    @IBOutlet weak var maskButtonOutlet: UIButton!
    
    
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        home_LivingCollectionView.reloadData()
    }

}
