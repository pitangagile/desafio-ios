//
//  PitangMoviesAPI.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation
import Moya
enum PitangMoviesAPI {
    case movies(page: Int, pageSize: Int)
    case movieDetail(id: String)
}

extension PitangMoviesAPI : TargetType {
    var baseURL: URL {
        return URL(string: "https://desafio-mobile-pitang.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .movies:
            return "/movies/list"
        case .movieDetail(let id):
            return "/movies/detail/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movieDetail, .movies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .movies(let page, let pageSize):
            return .requestParameters(
                parameters: ["page" : page, "size" : pageSize],
                encoding: URLEncoding.queryString
            )
        case .movieDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
