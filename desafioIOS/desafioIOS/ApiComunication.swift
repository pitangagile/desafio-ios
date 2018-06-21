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
    
    class func getMoviesList(page: Int, size: Int, onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let parameters: Parameters = [
            "page": page,
            "size": size
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
            var movies: [Movie] = []
            //var i = 0
            for movie in value {
                let oneMovie = Movie()
                if let id = movie["_id"] as? String {
                    oneMovie.id = id
                }
                if let name = movie["name"] as? String {
                    oneMovie.name = name
                }
                if let urlImage = movie["url"] as? String {
                    oneMovie.imageURL = urlImage
                }
                movies.append(oneMovie)
            }
            onSuccess(movies)
        }
    }
    
    class func getMovieDescription(movieID: String, onSuccess: @escaping (_ detail: String) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let url = "https://desafio-mobile-pitang.herokuapp.com/movies/detail/\(movieID)"
        
        Alamofire.request(url, method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching: \(String(describing: response.result.error))")
                onFailure("Error while fetching: \(String(describing: response.result.error))")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                print("Malformed data recived")
                onFailure("Malformed data recived")
                return
            }
            guard let returnDetail = value["description"] as? String else {
                onFailure("Malformed data recived")
                return
            }
            
            onSuccess(returnDetail)
            
        }
        
    }
    
    class func imageDownloadTask(imageURL: String, onSuccess: @escaping (_ image: UIImage, _ imageURL: URL) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let url = URL(string: imageURL)
        //let imageResponse: UIImage = UIImage()
        let imageView: UIImageView = UIImageView.init()
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, urlImage) in
            if image != nil {
                //imageResponse = image!
                onSuccess(image!, urlImage!)
            } else {
                onFailure("Failed to download movie image.")
            }
        }
    }
    
}
