//
//  Movie.swift
//  desafioIOS
//
//  Created by CITi on 20/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    var id: String?
    var image: UIImage?
    var name: String?
    var description: String?
    var imageURL: String?
    
    init() {
        self.id = ""
        self.image = UIImage.init()
        self.name = ""
        self.description = ""
        self.imageURL = ""
    }
    
}
