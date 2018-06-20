//
//  ServiceHelper.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceHelper : NSObject {
    
    static func executeRequest(r: ServiceRequest, completion: @escaping(NSError?, JSON?)->Void){
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
}

class ServiceRequest : NSObject {
    var url: String!
    var method: HTTPMethod = HTTPMethod.get
    
    func getListMoviesRequest(with page: Int, and size: Int) -> ServiceRequest{
        self.url = String(format: URL_listMovies, page, size)
        return self
    }
    
    func getDetailMovieRequest(with id: String) -> ServiceRequest{
        self.url = String(format: URL_detailMovie, id)
        return self
    }
}
