//
//  SectionsforHome_Living.swift
//  Home&Living
//
//  Created by Appinventiv on 18/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class SectionsforHome_Living: UITableViewCell {

    @IBOutlet weak var collectionofBrands: UICollectionView!
    @IBOutlet weak var brandsLabel: UILabel!
    
    
    @IBOutlet weak var maskButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
