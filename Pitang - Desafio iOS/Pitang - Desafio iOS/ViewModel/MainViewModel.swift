//
//  MainViewModel.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import Foundation


class MainViewModel : NSObject {
    
    var moviesList:[MovieModel] = []
    var lastPage = 0
    
    func listMovies(at page: Int){
        let request = ServiceRequestModel().getListMoviesRequest(with: page, and: MOVIES_LIST_SIZE)
        
        self.lastPage = page
        
        ServiceHelper.executeRequest(r: request){
            ( error, json ) in
            
            if let err = error {
                NotificationCenter.default.post(name: NOTIFICATION_receivedListMovies, object: err)
                
            }else if let arrMovies = json?.arrayObject as? [Dictionary<String, Any>]{
                
                for obj in arrMovies{
                    self.moviesList.append( MovieModel.convertToModel(dictionary: obj) )
                }
                
                NotificationCenter.default.post(name: NOTIFICATION_receivedListMovies, object: nil)
            }else{
                let err = NSError(domain: "The server behaved unexpectedly :( Try again later!", code: 002, userInfo: nil)
                NotificationCenter.default.post(name: NOTIFICATION_receivedListMovies, object: err)
            }
        }
        
    }
}
