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
    
    /*Function that requests a json of movies and returns an array of movies to a completion block when succeeds. When the request fails, it returns an error message to a completion block.*/
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
    
    /*Function that requests details from one movie at a time. When succeeds, it returns a string containing the movie description. When it fails, returns an error message to a completion block.*/
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
    
    /*Function that makes the movie image download requisition. When succeeds, it tries to store the image in cash memory (memory or disk) to improve efficiency in future acesses. Then, the function returns the image and the image url to a completion block. When the image isn't downloaded, the function returns an error message to a completion block.*/
    class func imageDownloadTask(imageURL: String, onSuccess: @escaping (_ image: UIImage, _ imageURL: URL) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let url = URL(string: imageURL)
        let imageView: UIImageView = UIImageView.init()
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, urlImage) in
            if image != nil {
                onSuccess(image!, urlImage!)
            } else {
                onFailure("Failed to download movie image.")
            }
        }
    }
    
}
