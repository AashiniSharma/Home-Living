//
//  Web Controller.swift
//  Home&Living
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import SwiftyJSON


class WebController {
    
    func fetchDataFromPixabay(withQuery query: String,
                              page  : Int,
                              success : @escaping (([ImageInfo]) -> Void),
                              failure : @escaping ((Error) -> Void)) {
        
        let URL = "https://pixabay.com/api/"
        
        let parameters = ["key" : "4608977-0fba8b8dc6c54482ac299615e",
                          "q" : query,
                        "page" : page
        ] as [String : Any]
        
        NetworkController().GET(URL: URL,
                                parameters : parameters,
                                success : { (json : JSON) in
                                                                        
                                    let imagesArray = json["hits"].arrayValue
                                    
                                    var imageModels = [ImageInfo]()
                                    
                                    for image in imagesArray {
                                        
                                        imageModels.append(ImageInfo(withJSON: image))
                                    }
                                    
                                    success(imageModels)
                                    
        }, failure : { (error : Error) in
            
            failure(error)
        })
        
    }

    
    
    
}
