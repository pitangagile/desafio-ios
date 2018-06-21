//
//  Extensions.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 21/06/2018.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func setupCell(using model: MovieModel?){
        if let model = model {
            self.accessoryType = .disclosureIndicator
            ServiceHelper.downloadImage(url: model.imageUrl!, id: model.id!) { (image) in
                DispatchQueue.main.async {
                    self.imageView?.image = image ?? #imageLiteral(resourceName: "icon-error")
                    self.textLabel?.text = model.name
                }
            }
            
        }
    }
    
}
