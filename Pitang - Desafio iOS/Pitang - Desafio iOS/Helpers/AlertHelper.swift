//
//  AlertHelper.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 21/06/2018.
//

import Foundation
import UIKit

class AlertHelper: NSObject {
    
    static func showDefaultSimpleAlert(title: String, mensage: String, parent: UIViewController, buttonTitle: String, completion: @escaping()->Void ){
        let alert = UIAlertController(title: title, message: mensage, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
            completion()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        parent.present(alert, animated: true, completion: nil)
    }
    
    
}
