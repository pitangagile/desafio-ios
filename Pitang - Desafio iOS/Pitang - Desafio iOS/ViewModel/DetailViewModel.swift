//
//  DetailViewModel.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 21/06/2018.
//

import Foundation
import UIKit

class DetailViewModel : NSObject {
    
    var movie: MovieModel?
    
    func detailMovie(id: String){
        let request = ServiceRequestModel().getDetailMovieRequest(with: id)
        
        ServiceHelper.executeRequest(r: request){
            ( error, json ) in
            
            if let err = error {
                NotificationCenter.default.post(name: NOTIFICATION_receivedDetailMovie, object: err)
                
            }else if let movie = json?.dictionaryObject{
                self.movie = MovieModel.convertToModel(dictionary: movie)
                NotificationCenter.default.post(name: NOTIFICATION_receivedListMovies, object: nil)
                
            }else{
                let err = NSError(domain: "The server behaved unexpectedly :( Try again later!", code: 002, userInfo: nil)
                NotificationCenter.default.post(name: NOTIFICATION_receivedListMovies, object: err)
            }
        }
    }
    
}
