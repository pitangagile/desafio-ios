//
//  ServiceHelper.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class ServiceHelper : NSObject {
    
    static func executeRequest(r: ServiceRequestModel, completion: @escaping(NSError?, JSON?)->Void){
        Alamofire.request(r.url, method: r.method).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(nil, json)
            case .failure(let error):
                completion(error as NSError, nil)
            }
        }
    }
    
    static func downloadImage(url: String, id: String, rounded:Bool = false, completion: @escaping(UIImage?)->Void){
        
        let cache = NSCache<NSString, UIImage>()
        if let cache = cache.object(forKey: id as NSString){
            completion(cache)
        }
        else{
            Alamofire.request(url).responseImage { (response) in
                if let imageData = response.result.value {
                    cache.setObject(imageData, forKey: id as NSString)
                    
                    let img = rounded ? imageData.af_imageRoundedIntoCircle() : imageData
                    
                    completion(img)
                    
                }else{
                    completion(nil)
                }
            }
        }
    
    }
}
