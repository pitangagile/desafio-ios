//
//  ServiceRequestModel.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 21/06/2018.
//

import Foundation
import Alamofire

class ServiceRequestModel : NSObject {
    var url: String!
    var method: HTTPMethod = HTTPMethod.get
    
    func getListMoviesRequest(with page: Int, and size: Int) -> ServiceRequestModel{
        self.url = String(format: URL_listMovies, page, size)
        return self
    }
    
    func getDetailMovieRequest(with id: String) -> ServiceRequestModel{
        self.url = String(format: URL_detailMovie, id)
        return self
    }
}
