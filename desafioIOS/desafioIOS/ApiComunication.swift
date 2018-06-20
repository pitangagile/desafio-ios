//
//  ApiComunication.swift
//  desafioIOS
//
//  Created by CITi on 20/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class ApiComunication {
    
    class func getMoviesList(page: Int, size: Int, onSuccess: @escaping (_ movies: Movie) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        
        //var movies: [Movie] = []
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let parameters: Parameters = [
            "page": 0,
            "size": 3
        ]
        Alamofire.request("https://desafio-mobile-pitang.herokuapp.com/movies/list?", method: .get, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            print(response)
            
            guard response.result.isSuccess else {
                print("Error while fetching: \(String(describing: response.result.error))")
                onFailure("Error while fetching: \(String(describing: response.result.error))")
                return
            }
            
            guard let value = response.result.value as? [[String: Any]] else {
                print("Malformed data recived")
                onFailure("Malformed data recived")
                return
            }
            //var i = 0
            for movie in value {
                var image: UIImageView?
                guard let name = movie["name"] as? String else {
                    return
                }
                if let urlImage = movie["url"] as? String {
                    let oneMovie = Movie()
                    let url = URL(string: urlImage)!
                    image?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
                        if image != nil {
                            oneMovie.image = image!
                            oneMovie.name = name
                            onSuccess(oneMovie)
                        } else {
                            oneMovie.name = name
                            onSuccess(oneMovie)
                        }
                    })
                }
            }
        }
    }
    
}
