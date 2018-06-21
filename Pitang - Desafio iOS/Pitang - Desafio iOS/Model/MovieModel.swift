//
//  MovieModel.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import Foundation

class MovieModel: NSObject {
    var id: String? 
    var name: String?
    var imageUrl: String?
    var desc: String?
    
    
    static func convertToModel(dictionary: (Dictionary<String, Any>)) -> MovieModel{
        
        let movie = MovieModel()
        
        if let id = dictionary["_id"] as? String {
            movie.id = id
        }
        
        if let name = dictionary["name"] as? String {
            movie.name = name
        }
        
        if let url = dictionary["url"] as? String {
            movie.imageUrl = url
        }
        
        if let description = dictionary["description"] as? String {
            movie.desc = description
        }
        
        return movie
    }
    
}
