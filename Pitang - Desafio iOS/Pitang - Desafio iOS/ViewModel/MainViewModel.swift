//
//  MainViewModel.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import Foundation


class MainViewModel : NSObject {
    
    func listMovies(at page: Int){
        let request = ServiceRequest().getListMoviesRequest(with: page, and: MOVIES_LIST_SIZE)
    
        ServiceHelper.executeRequest(r: request){
            ( error, json ) in
            
            if let err = error {
                
                
            }else{
                
            }
        }
        
    }
}
