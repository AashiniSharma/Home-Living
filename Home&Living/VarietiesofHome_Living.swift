//
//  VarietiesofHome_Living.swift
//  Home&Living
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class VarietiesofHome_Living: UICollectionViewCell {
    
    var cellData : ImageInfo!
     //MARK: IB Outlets
    @IBOutlet weak var favouritesButtonOutlet: UIButton!
    @IBOutlet weak var varietiesImages: UIImageView!
    @IBOutlet weak var varietyLabel: UILabel!
    
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        varietiesImages.image = nil
        favouritesButtonOutlet.isSelected = false
    }

}
