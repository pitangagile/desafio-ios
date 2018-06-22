//
//  MoviesViewModel.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift

class MoviesViewModel {
    var movies = Variable<[MoviePreview]>([])
    let dataStore = PitangMovieDataStore()
    
    func loadMovies(page: Int) {
        self.dataStore
            .moviesList(page: page, pageSize: 6)
            .subscribe { (event) in
                print(event)
                switch event {
                case .next(let movies):
                    if !movies.isEmpty {
                        self.movies.value += movies
                    }
                default:
                    break
                }
        }
    }
}
